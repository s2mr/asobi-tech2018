//
//  AboutAppViewController.swift
//  merry
//
//  Created by 下村一将 on 2018/03/04.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    private let webView: UIWebView = {
        let v = UIWebView(frame: .zero)
        return v
    }()

    override func loadView() {
        super.loadView()
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "about", ofType: "html")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        webView.loadHTMLString(String.init(data: data, encoding: .utf8)!, baseURL: nil)
    }
}
