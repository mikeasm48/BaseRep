//
//  SearchPresenterTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
import XCTest
@testable import DiplomMovieDB

class SearchPresenterTests: XCTestCase {
    var viewController: SearchViewControllerSpy!
    var presenter: SearchPresenter!

    override func setUp() {
        super.setUp()
        viewController = SearchViewControllerSpy()
        viewController.expect = expectation(description: "Expect for data presenting")
        presenter = SearchPresenter()
        presenter.viewController = viewController
    }

    override func tearDown() {
        viewController = nil
        presenter = nil
        super.tearDown()
    }

    func testThatPresenterCanPresentData() {
        //Arrange
        let moviesExpectedCount = 3
        let picturesExpectedCount = 2
        let movies = TestMovieCreator().createMovies(count: moviesExpectedCount)
        let imageData = TestPictureLoader().createPictures(count: picturesExpectedCount)
        //Act
        presenter.presentData(data: movies, imageData: imageData)
        //Assert
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
            }
        }
        XCTAssertEqual(viewController?.movies.count, moviesExpectedCount, "Incorrect movies result count")
        XCTAssertEqual(viewController?.images.count, picturesExpectedCount, "Incorrect pictures result count")
    }
}
