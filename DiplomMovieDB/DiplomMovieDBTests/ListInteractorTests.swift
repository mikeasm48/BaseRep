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
        interactor = ListInteractor(networkService: networkServiceStub)
        interactor.setOutput(output: presenter)
    }

    override func tearDown() {
        networkServiceStubForLoadImage = nil
        presenter = nil
        super.tearDown()
    }

//    func testThatInteractorCanLoadImage() {
//        //Arrange
//        let pathForLoadPicture =  "/5myQbDzw3l8K9yofUXRJ4UTVgam.jpg"
//
//        let interactor = ListInteractor(networkService: networkServiceStubForLoadImage)
//        interactor.interactorOutput = presenter
//        Act
//        interactor.loadDataAsync()
//
//        Assert
//        XCTAssertEqual(presenter?.countData, 20, "Incorrect result count")
//    }

    func testThatInteractorCanLoadData() {
        //Arrange
        //Act
        interactor.loadDataAsync()
        //Assert
        //sleep(20)
        print("Spy before assert: \(presenter.countData)")
        XCTAssertEqual(presenter.countData, 20, "Incorrect result count")
    }
}
