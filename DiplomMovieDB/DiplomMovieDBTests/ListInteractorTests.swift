//
//  NetworkServiceTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class ListInteractorTests: XCTestCase {
    var networkServiceStub: NetworkServiceStub!
    var presenter: ListPresenterSpy!
    var interactor: ListInteractor!

    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        presenter = ListPresenterSpy()
        presenter.expect = expectation(description: "Expect for data loading")
        interactor = ListInteractor(networkService: networkServiceStub)
        interactor.presenter = presenter
    }

    override func tearDown() {
        networkServiceStub = nil
        presenter = nil
        super.tearDown()
    }

    func testThatInteractorCanLoadData() {
        //Act
        interactor.loadDataAsync()
        //Assert
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
            }
        }
        XCTAssertEqual(presenter.countData, 20, "Incorrect result count")
    }
}
