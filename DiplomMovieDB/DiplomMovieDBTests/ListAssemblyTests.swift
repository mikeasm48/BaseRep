//
//  ListAssemblyTest.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

final class ListAssemblyTests: XCTestCase {

    override func setUp() {
      super.setUp()
    }

    override func tearDown() {
       super.tearDown()
    }

    func testBuild() {
        //act
        let viewController = ListAssembly.build() as? ListViewController
        let router = viewController?.router as? ListRouter
        let interactor = viewController?.interactor as? ListInteractor
        let presenter = interactor?.presenter as? ListPresenter
        let service = interactor?.networkService as? NetworkService
        //assert
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(service)
    }
}
