//
//  SampleView.swift
//  HWImageFilter
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

@objc(SampleView)
public class SampleView: UIImageView {
    private let filterName: String
    
    init(with name: String) {
        self.filterName = name
        super.init(image: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("no coder init")
    }
    
    public func getFilterName() -> String {
        return filterName
    }
}
