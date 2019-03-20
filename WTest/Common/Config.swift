//
//  Config.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

struct Config {
    static let tableViewCounter = 51
    static var endPoint: String {
        get {
            if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
                if let dic = NSDictionary(contentsOfFile: path) {
                    return dic["ENDPOINT"] as? String ?? ""
                }
            }
            return ""
        }
    }
}
