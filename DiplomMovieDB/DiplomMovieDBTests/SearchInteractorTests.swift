//
//  SearchInteractorTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class SearchInteractorTests: XCTestCase {
    var networkServiceStub: NetworkServiceStub!
    var presenter: SearchPresenterSpy!
    var interactor: SearchInteractor!

    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        presenter = SearchPresenterSpy()
        presenter.expect = expectation(description: "Expect for data loading")
        interactor = SearchInteractor(networkService: networkServiceStub)
        interactor.presenter = presenter
    }

    override func tearDown() {
        networkServiceStub = nil
        presenter = nil
        super.tearDown()
    }
    
    func testThatInteractorCanSearch() {
        //Arrange
        let searchText = "Some Movie To Search"
        //Act
        interactor.search(text: searchText)
        //Assert
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
            }
        }
        XCTAssertEqual(presenter.countData, 20, "Incorrect result count")
    }
}
