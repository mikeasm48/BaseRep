//
//  SyncronizedArray.swift
//  HWThreadSafeCollection
//
//  Created by Михаил Асмаковец on 11.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation
//Потокобезопасный массив
//Метод синхронизации: синхронная очередь на запись и чтение
public class SynchronizedArray<T> {
    private var array: [T] = []
    private let accessQueue = DispatchQueue(label: "com.hw.syncronized.array")
    
    public func append(newElement: T) {
        accessQueue.async {
            self.array.append(newElement)
            print("SyncronizedArray append: \(newElement)")
        }
    }
    
    public subscript(index: Int) -> T {
        set {
            accessQueue.async {
                self.array[index] = newValue
                print("SyncronizedArray set: \(newValue) at \(index)")
            }
        }
        get {
            var element: T!
            accessQueue.sync {
                element = self.array[index]
                print("SyncronizedArray get: \(String(describing: element)) at \(index)")
            }
            return element
        }
    }
}
