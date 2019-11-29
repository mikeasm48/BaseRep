//
//  NetworkServiceStub.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
@testable import DiplomMovieDB

class NetworkServiceStub: NetworkServiceInput {
    func getData(at path: URL, completion: @escaping (Data?) -> Void) {
        if path.absoluteString.starts(with: "https://image.tmd") {
            completion(loadImageData())
        } else {
            completion(loadList())
        }
    }

    private func loadImageData() -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "TestPicture", ofType: "jpg")
        let image = UIImage(contentsOfFile: filePath!)
        let data = image?.pngData()
        return data
    }

    private func loadList() -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "TestMovieList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        return data
    }
}
