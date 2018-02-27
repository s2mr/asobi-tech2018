
//
//  StoryViewController.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit
import RxSwift

class StoryViewController: UIViewController {

    fileprivate let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewButtomConstraint: NSLayoutConstraint!

    let chats: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        presenter?.loadChatRoom(index: chatRoomIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        presenter?.viewWillDisappear()
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension StoryViewController {
    func setupUI() {
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

    @objc func backgroundTapped() {
        print("backgroundTapped()")
    }
}

extension StoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chats.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = self.chats[indexPath.row]
//        if chat.isMyChat() {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChat") as! MyChatViewCell
//            cell.clipsToBounds = true
//            // Todo: isRead
//            cell.updateCell(text: chat.text, time: chat.time, isRead: true)
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "YourChat") as! YourChatViewCell
//            cell.clipsToBounds = true
//            cell.updateCell(text: chat.text, time: chat.time)
//            return cell
//        }

        return UITableViewCell()
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
