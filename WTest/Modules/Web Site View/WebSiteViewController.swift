//
//  WebSiteViewController.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit
import WebKit

class WebSiteViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressConstraintHeight: NSLayoutConstraint!
    
    var presenter: WebSiteViewToPresenterProtocol?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebSiteRouter.createModule(viewRef: self)
        addObserver()
        configWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 79 / 255, green: 22 / 255, blue: 56 / 255, alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 79 / 255, green: 22 / 255, blue: 56 / 255, alpha: 1)
    }
    
    func configWebView() {
        self.webView.navigationDelegate = self
        self.webView.scrollView.delegate = self
        self.progressView.alpha = 0
    }
}

extension WebSiteViewController: WebSitePresenterToViewProtocol, WKNavigationDelegate, UIScrollViewDelegate {
    func setTitleView(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func webViewLoadRequest(url: String) {
        let _url = URL(string: url)
        let request = URLRequest(url: _url!)
        webView.load(request)
    }
    
    func addObserver() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
    }
    
    func removeObserver() {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
    }
    
    func showProgressView() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.alpha = 1
        }, completion: nil)
    }
    
    func hideProgressView(isHide: Bool) {
        if isHide == true {
            self.progressConstraintHeight.constant = 0
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity:0.3, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
            return
        }
    }
    
    func setProgressView(float: Float) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity:0.3, options: .curveEaseInOut, animations: {
            self.progressView.progress = float
        }, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        return presenter?.observeValue(forKeyPath: keyPath, of: object, change: change, context: context) ?? ()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        return presenter?.webView(webView, didFinish: navigation) ?? ()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        return presenter?.webView(webView, didStartProvisionalNavigation: navigation) ?? ()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        return presenter?.webView(webView, didFail: navigation, withError: error) ?? ()
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        return presenter?.scrollViewWillBeginZooming(scrollView, with: view) ?? ()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        return presenter?.webView(webView, decidePolicyFor: navigationAction) ?? ()
    }
}
