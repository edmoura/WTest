//
//  PostalCodeInteractor.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import Moya

class PostalCodeInteractor: PostalCodePresenterToInteractorProtocol {
    var presenter: PostalCodeInteractorToPresenterProtocol?
    let concelho = MoyaProvider<ConcelhoService>()
    var request: Cancellable?
    func getPostalCode(callback: @escaping(Result<[ConcelhoModel]>) -> Void) {
        request = concelho.request(.getConcelhos(), completion: { (result) in
            switch result {
            case let .success(moyaResponse):
                if let _result = try? JSONDecoder().decode([ConcelhoModel].self, from: moyaResponse.data) {
                    callback(.success(_result))
                } else {
                    callback(.failure(WTestError.jsonNotSerializable))
                }
            case let .failure(error): callback(.failure(error))
            }
        })
    }
}
