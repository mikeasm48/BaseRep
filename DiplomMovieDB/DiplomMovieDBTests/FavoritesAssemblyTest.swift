//
//  FavoritesAssemblyTest.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

@testable import DiplomMovieDB
import XCTest

class FavoritesAssemblyTest: XCTestCase {
        override func setUp() {
            super.setUp()
        }

        override func tearDown() {
            super.tearDown()
        }

        func testBuild() {
            //act
            let viewController = FavoritesAssembly.build() as? FavoritesViewController
            let router = viewController?.router as? FavoritesRouter
            let interactor = viewController?.interactor as? FavoritesInteractor
            let presenter = interactor?.presenter as? FavoritesPresenter
            let service = interactor?.networkService as? NetworkService
            //assert
            XCTAssertNotNil(viewController)
            XCTAssertNotNil(router)
            XCTAssertNotNil(interactor)
            XCTAssertNotNil(presenter)
            XCTAssertNotNil(service)
        }
}
