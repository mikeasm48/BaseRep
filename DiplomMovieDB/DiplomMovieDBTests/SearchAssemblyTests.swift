//
//  SearchAssemblyTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

final class SearchAssemblyTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBuild() {
        //act
        let viewController = SearchAssembly.build() as? SearchViewController
        let router = viewController?.router as? SearchRouter
        let interactor = viewController?.interactor as? SearchInteractor
        let presenter = interactor?.presenter as? SearchPresenter
        let service = interactor?.networkService as? NetworkService
        //assert
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(service)
    }
}
