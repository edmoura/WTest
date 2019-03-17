//
//  PostalCodePresenter.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

class PostalCodePresenter: PostalCodeViewToPresenterProtocol {
    var view: PostalCodePresenterToViewProtocol?
    var interactor: PostalCodePresenterToInteractorProtocol?
    var router: PostalCodePresenterToRouterProtocol?
}

extension PostalCodePresenter: PostalCodeInteractorToPresenterProtocol {
    func viewDidLoad() {
        print("PostalCodePresenter viewDidLoad")
    }
}
