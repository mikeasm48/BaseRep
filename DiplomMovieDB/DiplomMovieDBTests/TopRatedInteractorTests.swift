//
//  TopRatedInteractorTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class TopRatedInteractorTests: XCTestCase {
    var networkServiceStub: NetworkServiceStub!
    var presenter: TopRatedPresenterSpy!
    var interactor: TopRatedInteractor!

    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        presenter = TopRatedPresenterSpy()
        presenter.expect = expectation(description: "Expect for data loading")
        interactor = TopRatedInteractor(networkService: networkServiceStub)
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
