//
//  TopRatedAssemblyTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

final class TopRatedAssemblyTest: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBuild() {
        //act
        let viewController = TopRatedAssembly.build() as? TopRatedViewController
        let router = viewController?.router as? TopRatedRouter
        let interactor = viewController?.interactor as? TopRatedInteractor
        let presenter = interactor?.presenter as? TopRatedPresenter
        let service = interactor?.networkService as? NetworkService
        //assert
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(service)
    }
}
