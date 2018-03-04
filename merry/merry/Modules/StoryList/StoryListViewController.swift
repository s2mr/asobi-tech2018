//
//  ViewController.swift
//  merry
//
//  Created by 下村一将 on 2018/02/27.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit

class StoryListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Story"
        let nib = UINib(nibName: "StoryListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StoryListTableViewCell")
        tableView.rowHeight = 70
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
//        tableView.rowHeight
    }
}

extension StoryListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
//            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            let vc = UIStoryboard(name: "SurpriseCamera", bundle: nil).instantiateInitialViewController()!
            present(vc, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: false)
        }else if indexPath.row == 3{
            let vc = UIStoryboard(name: "Clear", bundle: nil).instantiateInitialViewController()!
            present(vc, animated: true, completion: nil)
//            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
