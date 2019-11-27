//
//  NetworkServiceTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class NetworkServiceTests: XCTestCase {
    var interactorForList: Interactor!
    var interactorForImage: Interactor!
    var networkServiceStubForLoadMovieList: NetworkServiceStubForLoadMovieList!
    var networkServiceStubForLoadImage: NetworkServiceStubForLoadImage!

    override func setUp() {
        super.setUp()
        networkServiceStubForLoadMovieList = NetworkServiceStubForLoadMovieList()
        networkServiceStubForLoadImage = NetworkServiceStubForLoadImage()
        interactorForList = Interactor(networkService: networkServiceStubForLoadMovieList)
        interactorForImage = Interactor(networkService: networkServiceStubForLoadImage)
    }

    override func tearDown() {
        networkServiceStubForLoadMovieList = nil
        interactorForList = nil
        networkServiceStubForLoadImage = nil
        interactorForImage = nil
        super.tearDown()
    }

    func testThatInteractorCanLoadImage() {
        //Arrange
        let pathForLoadPicture =  "/5myQbDzw3l8K9yofUXRJ4UTVgam.jpg"
        var imageResult: UIImage?
        //Act
        interactorForImage.loadImage(imageName: pathForLoadPicture) {image in
            imageResult = image
        }
        //Assert
        XCTAssertNotNil(imageResult)
    }

    func testThatInteractorCanLoadDiscoverMovieListOrderedByPopularity() {
        //Arrange
        var resultArray: [MovieListItemModel] = []
        //Act
        interactorForList.loadDiscoverMovieList(sortBy: "popularity.desc") {models in
            resultArray = models
        }
        //Assert
        XCTAssertNotNil(resultArray)
        XCTAssertEqual(resultArray.count, 20, "Incorrect result count")
    }
}
