//
//  NetworkServiceStub.swift
//  HWImageFilterSwiftTests
//
//  Created by Михаил Асмаковец on 26.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation
@testable import HWImageFilter

class NetworkServiceStub: NetworkServiceInput {

    func getData(at path: String, parameters: [AnyHashable: Any]?,
                 completion: @escaping (Data?) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "testpicture", ofType: "png")
        let image = UIImage(contentsOfFile: path!)
        let data = image?.pngData()
        completion(data)
    }

    func getData(at path: URL, completion: @escaping (Data?) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "_photos", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        completion(data)
    }
}
