//
//  NetworkServiceStubForLoadImage.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
@testable import DiplomMovieDB

class NetworkServiceStubForLoadImage: NetworkServiceInput {
    func getData(at path: URL, completion: @escaping (Data?) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "TestPicture", ofType: "jpg")
        let image = UIImage(contentsOfFile: filePath!)
        let data = image?.pngData()
        completion(data)
    }
}
