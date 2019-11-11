
//
//  Ын.swift
//  HWThreadSafeCollection
//
//  Created by Михаил Асмаковец on 11.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

class SynchronizedArrayDemo {
    static let writeQueue = DispatchQueue(label: "com.demo.write.queue",
                                   qos: .userInteractive,
                                   attributes: [.concurrent],
                                   autoreleaseFrequency: .never,
                                   target: nil)
    static let readQueue1 = DispatchQueue(label: "com.demo.read1.queue")
    static let readQueue2 = DispatchQueue(label: "com.demo.read2.queue")
    
    static let removeQueue = DispatchQueue(label: "com.demo.remove.queue",
                                          qos: .userInteractive,
                                          attributes: [.concurrent],
                                          autoreleaseFrequency: .never,
                                          target: nil)
    
    static func demo() {
        print(">>> Проверка SyncronizedArray")
        
        let syncronizedArray = SynchronizedArray<Int>()
        
        writeQueue.async {
            for index in 0..<1000 {
                syncronizedArray.append(newElement: index)
            }
        }
        
        readQueue1.async {
            for index in 0..<1000 {
                _ = syncronizedArray[index]
            }
        }
        
        readQueue2.async {
            for index in 0..<1000 {
                _ = syncronizedArray[index]
            }
        }
        
        //Поскольку проверку на границы тут не делал, без sleep крашится с асинхронным remove
        sleep(1)
        removeQueue.async {
            for index in 0..<1000 {
               syncronizedArray.remove(element: index)
            }     
        }
    }
}
