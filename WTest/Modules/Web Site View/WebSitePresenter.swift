//
//  WebSitePresenter.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import WebKit

class WebSitePresenter: WebSiteViewToPresenterProtocol {
    var view: WebSitePresenterToViewProtocol?
    var interactor: WebSitePresenterToInteractorProtocol?
    var router: WebSitePresenterToRouterProtocol?
}

extension WebSitePresenter: WebSiteInteractorToPresenterProtocol {
    func viewDidLoad() {}
    
    func viewWillAppear() {
        view?.webViewLoadRequest(url: Config.endPoint)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view?.hideProgressView(isHide: true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        view?.showProgressView()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        view?.hideProgressView(isHide: false)
    }
    
    func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            if let progress = (change?[NSKeyValueChangeKey.newKey] as AnyObject).floatValue {
                view?.setProgressView(float: progress)
            }
            return
        }
        if keyPath == #keyPath(WKWebView.title) {
            if let title = change?[NSKeyValueChangeKey.newKey] as? String {
                view?.setTitleView(title: title)
            }
            return
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) {
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
}
