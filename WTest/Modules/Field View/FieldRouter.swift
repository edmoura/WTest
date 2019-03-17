//
//  FieldRouter.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

class FieldRouter: FieldPresenterToRouterProtocol {
    static func createModule(viewRef: FieldViewController) {
        let presenter: FieldViewToPresenterProtocol & FieldInteractorToPresenterProtocol = FieldPresenter()
        let interactor: FieldPresenterToInteractorProtocol = FieldInteractor()
        let router: FieldPresenterToRouterProtocol = FieldRouter()
        
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
