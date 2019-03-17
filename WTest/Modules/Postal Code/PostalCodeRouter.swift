//
//  PostalCodeRouter.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

class PostalCodeRouter: PostalCodePresenterToRouterProtocol {
    
    /*func pushToFruitDetail(with fruit: Fruit,from view: UIViewController) {
        let fruitDetailViewController = view.storyboard?.instantiateViewController(withIdentifier: "FruitDetailView") as! FruitDetailView
        FruitDetailWireFrame.createFruitDetailModule(with: fruitDetailViewController, and: fruit)
        view.navigationController?.pushViewController(fruitDetailViewController, animated: true)
    }*/
    
    static func createModule(viewRef: PostalCodeViewController) {
        let presenter: PostalCodeViewToPresenterProtocol & PostalCodeInteractorToPresenterProtocol = PostalCodePresenter()
        let interactor: PostalCodePresenterToInteractorProtocol = PostalCodeInteractor()
        let router: PostalCodePresenterToRouterProtocol = PostalCodeRouter()
        
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
