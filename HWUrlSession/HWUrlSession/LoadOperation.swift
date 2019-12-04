//
//  LoadOperation.swift
//  HWUrlSession
//
//  Created by Михаил Асмаковец on 04.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit
class LoadOperation: Operation {
    let controller: ViewController
    let text: String
    let delay: Int

    init(viewCntroller: ViewController, text: String, delay: Int) {
        self.controller = viewCntroller
        self.text = text
        self.delay = delay
    }

    override func main() {
        if isCancelled {
            return
        }
        sleep(UInt32(self.delay))
        controller.doSearch(by: text)

    }
}
