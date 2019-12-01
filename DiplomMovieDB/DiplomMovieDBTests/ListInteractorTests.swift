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
    var networkServiceStubForLoadImage: NetworkServiceStubForLoadImage!
    var presenter: PresenterSpy!
    var interactor: InteractorInputProtocol!

    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        presenter = PresenterSpy()
        presenter.expect = expectation(description: "Expect for data loading")
        interactor = ListInteractor(networkService: networkServiceStub)
        interactor.setOutput(output: presenter)
    }

    override func tearDown() {
        networkServiceStubForLoadImage = nil
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
