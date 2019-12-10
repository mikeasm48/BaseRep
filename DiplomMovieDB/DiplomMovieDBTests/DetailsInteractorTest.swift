//
//  DetailsInteractorTest.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
import CoreData
@testable import DiplomMovieDB

class DetailsInteractorTests: XCTestCase {
    var networkServiceStub: NetworkServiceStub!
    var coreDataStub: CoreDataStackProtocol!
    var presenter: DetailsPresenterSpy!
    var interactor: DetailsInteractor!
    var dataModelStub: DataModelProtocol!

    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        presenter = DetailsPresenterSpy()
        presenter.expect = expectation(description: "Expect for data")
        coreDataStub = MockCoreDataStack()
        dataModelStub = DataModelStub()
        interactor = DetailsInteractor(networkService: networkServiceStub, coreDataStack: coreDataStub)
        interactor.presenter = presenter
        interactor.dataModel = dataModelStub
    }

    override func tearDown() {
        networkServiceStub = nil
        coreDataStub = nil
        presenter = nil
        dataModelStub = nil
        super.tearDown()
    }

    func testThatInteractorCanCheckMovieSaved() {
        //Arrange
        let movie = createTestMovie(movieId: 123)
        //Act
        interactor.checkMovieSaved(movie: movie)
        //Assert
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
            }
        }
        XCTAssertNotNil(presenter.presentedState, "No presented result")
        guard let resultState = presenter.presentedState else {
            XCTFail("No result in presenter")
            return
        }
        XCTAssertTrue(resultState, "Incorrect saved movie state report to presenter")
    }

    func testThatInteractorCanCheckMovieNotSaved() {
        //Arrange
        let movie = createTestMovie(movieId: 222)
        //Act
        interactor.checkMovieSaved(movie: movie)
        //Assert
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
            }
        }
        XCTAssertNotNil(presenter.presentedState, "No presented result")
        guard let resultState = presenter.presentedState else {
            XCTFail("No result in presenter")
            return
        }
        XCTAssertFalse(resultState, "Incorrect saved movie state report to presenter")
    }

    func testThatInteractorCanSaveMovie() {
        //Arrange
        let movie = createTestMovie(movieId: 333)
        //Act
        interactor.saveMovie(movie: movie)
        //Assert
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
            }
        }
        XCTAssertNotNil(presenter.presentedState, "No presented result")
        guard let resultState = presenter.presentedState else {
            XCTFail("No result in presenter")
            return
        }
        XCTAssertTrue(resultState, "Incorrect saved movie state report to presenter")
    }

    func testThatInteractorCanDeleteSavedMovie() {
        //Arrange
        let movie = createTestMovie(movieId: 123)
        //Act
        interactor.deleteSavedMovie(movie: movie)
        //Assert
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
            }
        }
        XCTAssertNotNil(presenter.presentedState, "No presented result")
        guard let resultState = presenter.presentedState else {
            XCTFail("No result in presenter")
            return
        }
        XCTAssertFalse(resultState, "Incorrect saved movie state report to presenter")
    }

    private func createTestMovie(movieId: Int) -> MovieDataModel {
        return TestMovieCreator().createTestMovie(movieId: movieId)
    }
}
