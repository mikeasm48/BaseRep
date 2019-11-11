//
//  TSC.swift
//  HWThreadSafeCollection
//
//  Created by Михаил Асмаковец on 11.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

//Потокобезопасная коллекция
//Метод синхронизация: конкурентный поток с барьером
class TSC {
    private var _array: Array<Any>;
    private let queue = DispatchQueue(label: "com.hw.tsc.barrier",
                                      qos: .unspecified,
                                      attributes: .concurrent,
                                      autoreleaseFrequency: .never,
                                      target: nil)

    
    init (){
        _array = []
    }
    
    func append(object: Any) {
        queue.async(flags: .barrier) {
            self._array.append(object)
            print("TSC append \(object) new count \(String(describing: self._array.count))")
        }
    }
    
    func set(at index: Int, object: Any) {
        queue.async (flags: .barrier) {
            print("TSC set \(object) at \(index)")
            self._array[index] = object
        }
    }
    
    func get(at index: Int) -> Any? {
        var element: Any?

        queue.sync{
            if (index > self._array.count - 1) {
                element = nil
                print("TSC out bounds for index \(String(describing: index))  of \(self._array.count)")
            } else {
                element = _array[index]
            }
            print("TSC get \(String(describing: element))  at \(index)")
        }
        return element
    }
}
