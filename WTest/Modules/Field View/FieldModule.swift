//
//  FieldModule.swift
//  WTest
//
//  Created by Edson iMAC on 18/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

enum FieldModule: Int {
    case Normal
    case Number
    case Uppercase
    case Date
    case List
    static let allValues = [Normal, Number, Uppercase, Date, List]
}

/*texto normal
números
forçar maiúsculas
datas
seleccionar entrada duma lista*/
