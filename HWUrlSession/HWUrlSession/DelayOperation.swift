//
//  DelayOperation.swift
//  HWUrlSession
//
//  Created by Михаил Асмаковец on 05.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class DelayOperation: AsyncOperation {
    let delay: TimeInterval
    let controller: ViewController
    let text: String
    init(viewCntroller: ViewController, text: String, delay: TimeInterval) {
        self.delay = delay
        self.controller = viewCntroller
        self.text = text
    }
    override func main() {
        self.state = .executing
        let delayTime = DispatchTime.now() + Double(Int64(self.delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            print("DelayOperation!!!")
            self.controller.doSearch(by: self.text)
            self.state = .finished
        }
    }
}
