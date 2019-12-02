//
//  DetailsAssemblyTest.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

@testable import DiplomMovieDB
import XCTest

class DetailsAssemblyTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBuild() {
        //act
        let viewController = DetailsAssembly.build() as? DetailsViewController
        let router = viewController?.router as? DetailsRouter
        let interactor = viewController?.interactor as? DetailsInteractor
        let presenter = interactor?.presenter as? DetailsPresenter
        let service = interactor?.networkService as? NetworkService
        //assert
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(router)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(service)
    }

}
