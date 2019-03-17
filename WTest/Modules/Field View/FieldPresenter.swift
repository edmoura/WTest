//
//  FieldPresenter.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

class FieldPresenter: FieldViewToPresenterProtocol {
    var view: FieldPresenterToViewProtocol?
    var interactor: FieldPresenterToInteractorProtocol?
    var router: FieldPresenterToRouterProtocol?
}

extension FieldPresenter: FieldInteractorToPresenterProtocol {
    func viewDidLoad() {
        print("FieldPresenter viewDidLoad")
    }
}
