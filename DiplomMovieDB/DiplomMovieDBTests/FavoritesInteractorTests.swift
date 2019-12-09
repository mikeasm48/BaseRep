//
//  FavoritesInteractorTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
import CoreData
@testable import DiplomMovieDB

class FavoritesInteractorTests: XCTestCase {
//    var networkServiceStub: NetworkServiceStub!
    var presenter: FavoritesPresenterSpy!
    var interactor: FavoritesInteractor!
    
    override func setUp() {
        super.setUp()
//        networkServiceStub = NetworkServiceStub()
        presenter = FavoritesPresenterSpy()
        presenter.expect = expectation(description: "Expect for data loading")
//        interactor = TopRatedInteractor(networkService: networkServiceStub)
//        interactor.presenter = presenter
    }
    
    override func tearDown() {
//        networkServiceStub = nil
        presenter = nil
        super.tearDown()
    }
    
//    func testThatInteractorCanLoadData() {
        //Act
        //interactor.loadDataAsync()
        //Assert
//        waitForExpectations(timeout: 1) { (error) in
//            if let error = error {
//                XCTFail("WaitForExpectationsWithTimeout error: \(error)")
//            }
//        }
//        XCTAssertEqual(presenter.countData, 20, "Incorrect result count")
//    }
}
