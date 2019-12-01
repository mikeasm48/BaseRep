//
//  PresenterSpy.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 29.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import XCTest
@testable import DiplomMovieDB

class PresenterSpy: InteractorOutputProtocol {
    var countData = 0
    var expect: XCTestExpectation?

    func reloadData(data: [InteractorOutputDataType]) {
        countData += data.count
        print("PresenterSpy: \(countData)")
        expect?.fulfill()
    }
}
