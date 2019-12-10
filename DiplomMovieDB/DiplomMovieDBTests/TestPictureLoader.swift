//
//  TestPictureLoader.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class TestPictureLoader {
    func loadTestPicture () -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "TestPicture", ofType: "jpg")
        let image = UIImage(contentsOfFile: filePath!)
        let data = image?.pngData()
        return data
    }

    func createPictures(count: Int) -> [String: Data] {
        var data: [String: Data] = [ : ]
        guard let picture = loadTestPicture() else {
            return data
        }
        for counter in 1 ... count {
            let key = "keypath" + String(counter)
            data.updateValue(picture, forKey: key)
        }
        return data
    }
}
