//
//  TSCDemo.swift
//  HWThreadSafeCollection
//
//  Created by Михаил Асмаковец on 11.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

class TSCDemo {
    static let appendQueue = DispatchQueue(label: "com.demo.write.queue",
                                          qos: .userInteractive,
                                          attributes: [.concurrent],
                                          autoreleaseFrequency: .never,
                                          target: nil)
    static let multiplyQueue = DispatchQueue(label: "com.demo.multuply.queue",
                                           qos: .userInteractive,
                                           attributes: [.concurrent],
                                           autoreleaseFrequency: .never,
                                           target: nil)
    static let readQueue = DispatchQueue(label: "com.demo.read.queue",
                                          qos: .userInteractive,
                                          attributes: [.concurrent],
                                          autoreleaseFrequency: .never,
                                          target: nil)
    
    static func demo() {
        print(">>> Проверка TSC")
        
        let syncronizedCollection = TSC()
        
        appendQueue.async {
            for index in 0..<1000 {
                syncronizedCollection.append(object: index)
            }
        }
        
        multiplyQueue.async {
            for index in 0..<1000 {
                guard let value = syncronizedCollection.get(at: index) as? Int else {
                    return
                }
                syncronizedCollection.set(at: index, object: value * 1000)
            }
        }
        
        readQueue.async {
            for index in 0..<1000 {
                _ = syncronizedCollection.get(at: index)
            }
        }
    }
}
