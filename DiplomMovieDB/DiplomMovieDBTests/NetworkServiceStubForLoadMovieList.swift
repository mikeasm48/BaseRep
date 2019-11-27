//
//  NetworkServiceStub.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation
@testable import DiplomMovieDB

class NetworkServiceStubForLoadMovieList: NetworkServiceInput {
    func getData(at path: URL, completion: @escaping (Data?) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "TestMovieList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        completion(data)
    }
}
