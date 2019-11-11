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
public class TSC<T: Equatable> {
    private var _array: [T];
    private let queue = DispatchQueue(label: "com.hw.tsc.barrier",
                                      qos: .unspecified,
                                      attributes: .concurrent,
                                      autoreleaseFrequency: .never,
                                      target: nil)
    
    init() {
        _array = []
    }
    
    func append(object: T) {
        queue.async(flags: .barrier) {
            self._array.append(object)
            print("TSC append \(object) new count \(String(describing: self._array.count))")
        }
    }
    
    func set(at index: Int, object: T) {
        queue.async (flags: .barrier) {
            print("TSC set \(object) at \(index)")
            self._array[index] = object
        }
    }
    
    func get(at index: Int) -> Any? {
        var element: Any?
        queue.sync{
            if (checkElement(at: index)) {
                element = _array[index]
            } else {
                element = nil
            }
            print("TSC get \(String(describing: element))  at \(index)")
        }
        return element
    }
    
    //Удаление элемента
    func remove (object: T) {
        queue.async (flags: .barrier) {
            if let itemToRemoveIndex = self._array.firstIndex(of: object) {
                self._array.remove(at: itemToRemoveIndex)
                 print("TSC removed \(String(describing: object)) at \(itemToRemoveIndex)")
            } else {
                print("TSC cannot find object \(String(describing: object)) to remove")
            }
        }
    }

    //Прверка доступности элемента
    private func checkElement(at index: Int) -> Bool {
        if (index > self._array.count - 1) {
            print("TSC out of bounds for index \(String(describing: index))  of \(_array.count)")
            return false
        }
        return true
    }
}
