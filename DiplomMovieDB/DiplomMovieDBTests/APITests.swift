//
//  APITests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class APITests: XCTestCase {
    //Проверка формирования URL списка загрузки изображения
    func testGenerateLoadImagePath() {
        //Arrange
        let goodResult = "https://image.tmdb.org/t/p/w500/5myQbDzw3l8K9yofUXRJ4UTVgam.jpg"
        let paramImageName = "/5myQbDzw3l8K9yofUXRJ4UTVgam.jpg"
        //Act
        let result = API.loadImagePath(imageName: paramImageName)
        //Assert
        XCTAssertEqual(result.absoluteString, goodResult,
                       "API generated wrong url for load image")
    }

    //Проверка формирования URL списка загрузки популярных фильмов
    func testGenerateDiscoverPath() {
        //Arrange
        let goodResult = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=836b9e978d31e45e403551bf7773f47d"
        let paramSortBy = "popularity.desc"
        //Act
        let result = API.discoverPath(sortBy: paramSortBy)
        //Assert
        XCTAssertEqual(result.absoluteString, goodResult,
                       "API generated wrong url discover popular sorted movie list")
    }
}
