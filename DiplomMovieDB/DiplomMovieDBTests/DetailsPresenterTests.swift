//
//  DetailsPresenterTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
import XCTest
@testable import DiplomMovieDB

class DetailsPresenterTests: XCTestCase {
    var viewController: DetailsViewControllerSpy!
    var presenter: DetailsPresenter!

    override func setUp() {
        super.setUp()
        viewController = DetailsViewControllerSpy()
//        viewController.expect = expectation(description: "Expect for data presenting")
        presenter = DetailsPresenter()
        presenter.detailsViewFactory = DetailsViewFactoryStub()
        presenter.viewController = viewController
    }

    override func tearDown() {
        viewController = nil
        presenter = nil
        super.tearDown()
    }

    func testThatPresenterCanSetDetails() {
        //Arrange
        let movieData = TestMovieCreator().createTestMovie(movieId: 1)
        let imageData = TestPictureLoader().loadTestPicture()
        //Act
        presenter.setDetails(movie: movieData, posterData: imageData, backdropData: imageData, savedState: true)
        //Assert
        XCTAssertNotNil(viewController?.posterImage, "Incorrect poster result  == nil")
        XCTAssertNotNil(viewController?.movieSavedStated, "Incorrect movied saved state  == nil")
    }

    func testThatPresenterCanSetMovieSavedState() {
        let correctState = true
        //Act
        presenter.setMovieSavedState(correctState)
        //Assert
        XCTAssertNotNil(viewController?.movieSavedStated, "Movie saved state did not set")
        XCTAssertTrue(viewController?.movieSavedStated ?? !correctState, "Incorrect movie state set by presenter")
    }

    func testThatPresenterCanSetMovieNotSavedState() {
        let correctState = false
        //Act
        presenter.setMovieSavedState(correctState)
        //Assert
        XCTAssertNotNil(viewController?.movieSavedStated, "Movie saved state did not set")
        XCTAssertFalse(viewController?.movieSavedStated ?? !correctState, "Incorrect movie state set by presenter")
    }
}
