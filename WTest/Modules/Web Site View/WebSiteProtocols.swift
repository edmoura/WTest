//
//  WebSiteProtocols.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import WebKit

protocol WebSitePresenterToViewProtocol: class {
    //Presenter -> View
    func webViewLoadRequest(url: String)
    func addObserver()
    func removeObserver()
    func showProgressView()
    func hideProgressView(isHide: Bool)
    func setProgressView(float: Float)
    func setTitleView(title: String)
}

protocol WebSiteViewToPresenterProtocol: class {
    //View -> Presenter
    var view: WebSitePresenterToViewProtocol? {get set}
    var interactor: WebSitePresenterToInteractorProtocol? {get set}
    var router: WebSitePresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func viewWillAppear()
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction)
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?)
    func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    
}

protocol WebSitePresenterToInteractorProtocol: class {
    //Presenter -> Interactor
    var presenter: WebSiteInteractorToPresenterProtocol? {get set}
}

protocol WebSiteInteractorToPresenterProtocol: class {
    //Interactor -> Presenter
}

protocol WebSitePresenterToRouterProtocol: class {
    //Presenter -> Router
    static func createModule(viewRef: WebSiteViewController)
}
