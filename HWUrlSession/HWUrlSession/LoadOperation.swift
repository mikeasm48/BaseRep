//
//  LoadOperation.swift
//  HWUrlSession
//
//  Created by Михаил Асмаковец on 04.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit
class LoadOperation: Operation {
    public typealias Closure = (LoadOperation) -> ()
    let closure: Closure
    let delay: TimeInterval

    init(delay: TimeInterval, closure: @escaping Closure) {
       self.delay = delay
        self.closure = closure
    }

    override func main() {
        if isCancelled {
            return
        }
        let delayTime = DispatchTime.now() + Double(Int64(self.delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        sleep(UInt32(self.delay))
        self.closure(self)
//        DispatchQueue.main.asyncAfter(deadline: delayTime) {
//            self.closure(self)
//        }

    }
}
