
//
//  StoryViewController.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StoryViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var footerView: StoryFooterView!

    private let viewModel = StoryViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension StoryViewController {
    private func setupUI() {
        tableView.backgroundColor = .black
        tableView.separatorColor = UIColor.clear
        tableView.estimatedRowHeight = 10000
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .interactive

        tableView.register(UINib(nibName: "YourChatViewCell", bundle: nil), forCellReuseIdentifier: "YourChat")
        tableView.register(UINib(nibName: "MyChatViewCell", bundle: nil), forCellReuseIdentifier: "MyChat")

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped))
        tapRecognizer.cancelsTouchesInView = false // TableViewへタップイベントを流す
        self.tableView.addGestureRecognizer(tapRecognizer)
    }

    private func subscribe() {
        viewModel.choice1.map { $0.text }
            .subscribe(onNext: { [weak self] (str) in
                self?.footerView.button1.setTitle(str, for: .normal)
            }).disposed(by: disposeBag)
        viewModel.choice2.map { $0.text }
            .subscribe(onNext: { [weak self] (str) in
                self?.footerView.button2.setTitle(str, for: .normal)
            }).disposed(by: disposeBag)
        viewModel.choice3.map { $0.text }
            .subscribe(onNext: { [weak self] (str) in
                self?.footerView.button3.setTitle(str, for: .normal)
            }).disposed(by: disposeBag)


        footerView.button1.rx.tap.withLatestFrom(viewModel.choice1.asObservable())
            .subscribe(onNext: { [weak self] (c) in
                                self?.viewModel.nextChat(nextId: c.nextId)
                                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        footerView.button2.rx.tap.withLatestFrom(viewModel.choice2.asObservable())
            .subscribe(onNext: { [weak self] (c) in
                self?.viewModel.nextChat(nextId: c.nextId)
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        footerView.button3.rx.tap.withLatestFrom(viewModel.choice3.asObservable())
            .subscribe(onNext: { [weak self] (c) in
                self?.viewModel.nextChat(nextId: c.nextId)
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
    }

    @objc func backgroundTapped() {
        viewModel.nextChat()
        self.tableView.reloadData()
    }
}

extension StoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = viewModel.chats[indexPath.row]
        switch chat.owner {
        case .self:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChat") as! MyChatViewCell
            cell.clipsToBounds = true
            // Todo: isRead
            cell.updateCell(text: chat.text, time: "", isRead: true)
            return cell
        case .other:
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourChat") as! YourChatViewCell
            cell.clipsToBounds = true
            cell.updateCell(text: chat.text, time: "")
            return cell
        }
    }
}

extension StoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        self.bottomView.chatTextField.resignFirstResponder()
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
}
