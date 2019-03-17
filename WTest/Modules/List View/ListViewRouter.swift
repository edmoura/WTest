//
//  ListViewRouter.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

class ListViewRouter: ListViewPresenterToRouterProtocol {
    static func createModule(viewRef: ListViewController) {
        let presenter: ListViewViewToPresenterProtocol & ListViewInteractorToPresenterProtocol = ListViewPresenter()
        let interactor: ListViewPresenterToInteractorProtocol = ListViewInteractor()
        let router: ListViewPresenterToRouterProtocol = ListViewRouter()
        
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
