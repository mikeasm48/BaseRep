//
//  FilterTapRecognizer.swift
//  HWImageFilter
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

class FilterTapRecognizer: UITapGestureRecognizer {
    var filterName: String

    init(target: Any?, action: Selector?, filter name: String) {
        self.filterName = name
        super.init(target: target, action: action)
    }

    required init(coder: NSCoder) {
        fatalError("no coder init")
    }
}
