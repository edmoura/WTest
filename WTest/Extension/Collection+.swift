//
//  Collection+.swift
//  WTest
//
//  Created by Edson iMAC on 22/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
