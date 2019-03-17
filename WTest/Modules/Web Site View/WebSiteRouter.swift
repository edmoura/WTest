//
//  WebSiteRouter.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

class WebSiteRouter: WebSitePresenterToRouterProtocol {
    static func createModule(viewRef: WebSiteViewController) {
        let presenter: WebSiteViewToPresenterProtocol & WebSiteInteractorToPresenterProtocol = WebSitePresenter()
        let interactor: WebSitePresenterToInteractorProtocol = WebSiteInteractor()
        let router: WebSitePresenterToRouterProtocol = WebSiteRouter()
        
        viewRef.presenter = presenter
        presenter.view = viewRef
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main" ,bundle: Bundle.main)
    }
}
