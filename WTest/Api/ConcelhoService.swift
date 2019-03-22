//
//  ConcelhoService.swift
//  WTest
//
//  Created by Edson iMAC on 21/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import Moya

enum ConcelhoService {
    case getConcelhos()
}

extension ConcelhoService: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.lovetatoo.com.br/concelhos.json")!
    }
    
    var path: String {
        switch self {
        case .getConcelhos():
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getConcelhos():
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getConcelhos():
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type":"application/json; charset=utf-8"]
    }
    
    
}
