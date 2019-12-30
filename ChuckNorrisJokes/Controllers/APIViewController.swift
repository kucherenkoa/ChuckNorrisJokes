//
//  APIViewController.swift
//  ChuckNorrisJokes
//
//  Created by Andrei Kucherenko on 28.12.2019.
//  Copyright © 2019 Andrei Kucherenko. All rights reserved.
//

import UIKit
import WebKit

class APIViewController: UIViewController {
    var webView: WKWebView!
    let progressView = UIProgressView(progressViewStyle: .default)
    private var estimatedProgressObserver: NSKeyValueObservation?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgressView()
        setupEstimatedProgressObserver()
        
        if let initialUrl = URL(string: "http://www.icndb.com/api/") {
            setupWebview(url: initialUrl)
        }
        
    }
    
    // MARK: - Setup ProgressView
    private func setupProgressView() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(progressView)
        progressView.isHidden = true
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            
            progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
    }
    
    private func setupEstimatedProgressObserver() {
        estimatedProgressObserver = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
            self?.progressView.isHidden = webView.estimatedProgress < 1 ? false : true
            self?.progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    // MARK: - Setup Webview
    private func setupWebview(url: URL) {
        let request = URLRequest(url: url)
        
        webView.navigationDelegate = self
        webView.load(request)
    }
    
}

// MARK: - WKNavigationDelegate
extension APIViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("didFinish")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }
    
}
