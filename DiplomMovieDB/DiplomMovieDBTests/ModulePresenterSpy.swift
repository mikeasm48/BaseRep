//
//  ModulePresenterSpy.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class ModulePresenterSpy: ModulePresenterProtocol {
    var countData = 0
    var expect: XCTestExpectation?
    func presentData(data: [MovieDataModel], imageData: [String: Data]) {
        countData += data.count
        expect?.fulfill()
    }
}
