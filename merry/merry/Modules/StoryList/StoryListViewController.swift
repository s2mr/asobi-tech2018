//
//  ViewController.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit
import RxSwift
import AVFoundation

class StoryListViewController: UIViewController {

    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    private let infoButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.backgroundColor = .black
        b.layer.cornerRadius = 30
        b.setImage(UIImage(named: "info_icon1"), for: .normal)
        return b
    }()

    override func loadView() {
        super.loadView()
        view.addSubview(infoButton)
        infoButton.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.right.bottom.equalToSuperview().offset(-30)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Story"
        let nib = UINib(nibName: "StoryListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StoryListTableViewCell")
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = UITableViewAutomaticDimension

        infoButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let wself = self else { return }
            let vc = UIStoryboard(name: "Info", bundle: nil).instantiateInitialViewController()!
            wself.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            break
        default:
            let alert = UIAlertController(title: "ささやかなアドバイス💫", message: "快適にお楽しみいただくために腕を伸ばしてプレイするとよいです👍ゲームオーバー時に演出効果のためカメラを利用します。", preferredStyle: .alert)
            let ok = UIAlertAction(title: "👍", style: .default) { _ in
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    //                guard  else { return }
                    guard let wself = self, granted else { return }
                    let alert = UIAlertController(title: "", message: "Thank you💫", preferredStyle: .alert)
                    wself.present(alert, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
                        self?.dismiss(animated: true, completion: nil)
                    })
                }
            }
            let cancel = UIAlertAction(title: "👊", style: .cancel)
            alert.addAction(ok)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
}

extension StoryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryListTableViewCell") as! StoryListTableViewCell
        return cell
    }
}

extension StoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = UIStoryboard(name: "Story", bundle: nil).instantiateInitialViewController()!
            vc.title = "メリーさん"
            self.navigationController?.pushViewController(vc, animated: true)
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController?.navigationBar.isTranslucent = false
        } else if indexPath.row == 1 {
            let vc = UIStoryboard(name: "Call", bundle: nil).instantiateInitialViewController()!
            present(vc, animated: true, completion: nil)
        }else if indexPath.row == 2{
            let vc = UIStoryboard(name: "SurpriseCamera", bundle: nil).instantiateInitialViewController()!
            present(vc, animated: true, completion: nil)
        }else if indexPath.row == 3{
            let vc = UIStoryboard(name: "Clear", bundle: nil).instantiateInitialViewController()!
            present(vc, animated: true, completion: nil)
        }
    }
}
