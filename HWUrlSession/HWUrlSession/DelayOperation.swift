//
//  DelayOperation.swift
//  HWUrlSession
//
//  Created by Михаил Асмаковец on 05.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class DelayOperation: AsyncOperation {
    public typealias Closure = (DelayOperation) -> ()
    let closure: Closure
    
    let delay: TimeInterval

    init(delay: TimeInterval, closure: @escaping Closure) {
        self.delay = delay
        self.closure = closure
    }
    
    override func main() {
        self.state = .executing
        let delayTime = DispatchTime.now() + Double(Int64(self.delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.closure(self)
            self.state = .finished
        }
    }
}
