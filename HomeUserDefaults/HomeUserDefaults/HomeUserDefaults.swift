//
//  HomeUserDefaults.swift
//  HomeUserDefaults
//
//  Created by Михаил Асмаковец on 09.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol KeyProtocol {
    
    associatedtype Key
    
}

enum ResultError<T>: Error {
    
    case NoDataObjectForKey(key: T)
    
}


protocol HomeUserDefaultsGenericProtocol: KeyProtocol {
    
    associatedtype Value
    
    func set (_ value: Value, forKey: Key)
    
    func get (_ forKey: Key) -> Result<Value, Error>
    
    func remove (_ forKey: Key)
}

struct HomeUserDefaultsGeneric <T>: HomeUserDefaultsGenericProtocol  {
    
    typealias Key = String
    
    func set (_ value: T, forKey: Key){
        UserDefaults.standard.set(value, forKey: forKey)
        
    }
    
    func get (_ forKey: Key) -> Result<T, Error> {
        
        guard let res = UserDefaults.standard.object(forKey: forKey) as? T else {
            return .failure(ResultError<Key>.NoDataObjectForKey(key: forKey))
        }
        
        return .success(res)
    }
    
    func remove (_ forKey: Key) {
        UserDefaults.standard.removeObject(forKey: forKey)
    }
    
}

