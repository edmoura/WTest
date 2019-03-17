//
//  PostalCodeProtocols.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

protocol PostalCodePresenterToRouterProtocol: class {
    //Router
    static func createModule(viewRef: PostalCodeViewController)
}

protocol PostalCodePresenterToViewProtocol: class {
    //View
}

protocol PostalCodeViewToPresenterProtocol: class {
    //Presenter
    var view: PostalCodePresenterToViewProtocol? {get set}
    var interactor: PostalCodePresenterToInteractorProtocol? {get set}
    var router: PostalCodePresenterToRouterProtocol? {get set}
    func viewDidLoad()
    //func showFruitSelection(with fruit: Fruit, from view: UIViewController)
}

protocol PostalCodePresenterToInteractorProtocol: class {
    //Interactor
    var presenter: PostalCodeInteractorToPresenterProtocol? {get set}
    func getPostaCode()
}

protocol PostalCodeInteractorToPresenterProtocol: class {
    //Interactor -> Presenter
    func postalCodeDone()
}

