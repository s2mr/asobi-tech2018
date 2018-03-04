//
//  AboutAppViewController.swift
//  merry
//
//  Created by 下村一将 on 2018/03/04.
//  Copyright © 2018年 kazu. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController {

    private let progressBar: UIProgressView = {
        let p = UIProgressView(frame: .zero)
        p.progressViewStyle = .bar
        p.clipsToBounds = true
        return p
    }()

    private let webView: UIWebView = {
        let v = UIWebView(frame: .zero)
        return v
    }()

    private let spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView(frame: .zero)
        s.activityIndicatorViewStyle = .whiteLarge
        s.color = UIColor.darkGray
        return s
    }()

    override func loadView() {
        super.loadView()
//        view.addSubview(progressBar)
//        progressBar.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//            $0.top.equalToSuperview().offset(navigationController!.navigationBar.frame.size.height)
//            $0.height.equalTo(10)
//        }

        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        view.addSubview(spinner)
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "about", ofType: "html")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        webView.loadHTMLString(String.init(data: data, encoding: .utf8)!, baseURL: URL(fileURLWithPath: path))
        webView.delegate = self
    }
}


extension AboutAppViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
//        let timer = Timer(timeInterval: 0.1, repeats: true) { [weak self] (timer) in
//            guard let wself = self else { return }
//            if wself.progressBar.progress > 0.9 { return }
//            wself.progressBar.progress += 0.02
//        }
//        timer.fire()
        spinner.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
}
