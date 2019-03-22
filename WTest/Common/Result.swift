//
//  Result.swift
//  WTest
//
//  Created by Edson iMAC on 21/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
