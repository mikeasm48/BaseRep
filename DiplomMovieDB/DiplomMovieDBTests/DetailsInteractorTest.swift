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

    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        presenter = DetailsPresenterSpy()
        presenter.expect = expectation(description: "Expect for data")
        coreDataStub = MockCoreDataStack()
        interactor = DetailsInteractor(networkService: networkServiceStub, coreDataStack: coreDataStub)
        interactor.presenter = presenter
    }

    override func tearDown() {
        networkServiceStub = nil
        coreDataStub = nil
        presenter = nil
        super.tearDown()
    }

    func testThatInteractorCanCheckMovieSaved() {
        //Arrange
        let movie = MovieDataModel(movieId: 123, backdropPath: "", posterPath: "", title: "", overview: "", releaseDate: "")
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
}
