//
//  APITests.swift
//  HWImageFilterSwiftTests
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest

class APITests: XCTestCase {
    func testCanGenerateDefaultSearchPath() {
        //Arrange
        let goodResult = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=dab4052df3cc23ed39745a8cca163e0a&text=Cat&extras=url_m&format=json&nojsoncallback=1"
        let paramDefaultSearch = "Cat"
        let paramExtras = "url_m"
        //Act
        let result = API.searchPath(text: paramDefaultSearch, extras: paramExtras)
        //Assert
        XCTAssertTrue(result.absoluteString == goodResult)
    }
}
