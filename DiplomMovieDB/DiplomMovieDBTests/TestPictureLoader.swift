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
        let image = loadTestImage()
        let data = image?.pngData()
        return data
    }

    func loadTestImage () -> UIImage? {
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: "TestPicture", ofType: "jpg") else {
            return nil
        }
        let image = UIImage(contentsOfFile: filePath)
        return image
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
