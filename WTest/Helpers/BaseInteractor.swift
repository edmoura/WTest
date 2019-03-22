//
//  BaseInteractor.swift
//  WTest
//
//  Created by Edson iMAC on 21/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import Disk

struct BaseInteractor {
    func saveDataInDisk<T: Codable>(data: T, name: String) {
        do {
            try Disk.save(data, to: .caches, as: name)
        } catch let error as NSError {
            print("saveDataInDisk error:\(error)")
        }
    }
    
    func getDataFromDisk<T: Codable>(path: String) -> T? {
        let data = try? Disk.retrieve(path, from: .caches, as: T.self)
        return data ?? nil
    }
    
    func removeDataByPath(path: String){
        do {
            try Disk.remove(path, from: .caches)
        } catch let error as NSError {
            print("removeFlightMeta error:\(error)")
        }
    }
}
