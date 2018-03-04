//
//  InfoViewController.swift
//  merry
//
//  Created by 下村一将 on 2018/03/04.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    private let items = ["このアプリについて", "ライセンス情報"]
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension InfoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension InfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = AboutAppViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = LicenseViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
