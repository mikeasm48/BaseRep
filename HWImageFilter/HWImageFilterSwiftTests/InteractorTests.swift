//
//  InteractorTests.swift
//  HWImageFilterSwiftTests
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import HWImageFilter

class InteractorTests: XCTestCase {
    var interactor: Interactor!
    var networkServiceStub: NetworkServiceStub!

    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        interactor = Interactor(networkService: networkServiceStub)
    }

    override func tearDown() {
        networkServiceStub = nil
        interactor = nil
        super.tearDown()
    }

    func testThatInteractorCanLoadImage() {
        //Arrange
        let somePathForLoadImage = "https://www.flickr.com/services/rest/data"
        var resultImage: UIImage?
        //Act
        interactor.loadImage(at: somePathForLoadImage) { image in
            resultImage = image
        }
        //Assert
        XCTAssertNotNil(resultImage)
    }
    
    func testThatInteractorCanLoadImageList() {
        //Arrange
        var resultArray: [ImageModel] = []
        //Act
        interactor.loadImageList(by: "Cat") {models in
            resultArray = models
        }
        //Assert
        XCTAssertNotNil(resultArray)
        XCTAssertEqual(resultArray.count, 2, "Incorrect result count")
    }
}
