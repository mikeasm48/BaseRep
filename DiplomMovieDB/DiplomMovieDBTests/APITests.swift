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
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    //Проверка формирования URL списка загрузки изображения
    func testGenerateLoadImagePath() {
        //Arrange
        let goodResult = "https://image.tmdb.org/t/p/w500/5myQbDzw3l8K9yofUXRJ4UTVgam.jpg"
        let paramImageName = "/5myQbDzw3l8K9yofUXRJ4UTVgam.jpg"
        //Act
        let result = API.loadImagePath(imagePath: paramImageName)
        //Assert
        XCTAssertEqual(result.absoluteString, goodResult,
                       "API generated wrong url for load image")
    }

    //Проверка формирования URL списка загрузки популярных фильмов
    func testGenerateDiscoverPathByYear() {
        //Arrange
        let goodResult = "https://api.themoviedb.org/3/discover/movie?api_key=836b9e978d31e45e403551bf7773f47d&language=ru-RU&sort_by=popularity.desc&release_date.lte=2019-12-09&page=1"
        let paramSortBy = "popularity.desc"
        let paramReleaseDate = "2019-12-09"
        //Act
        let result = API.discoverPathByYear(sortBy: paramSortBy, maxReleaseDate: paramReleaseDate, page: 1)
        //Assert
        XCTAssertEqual(result.absoluteString, goodResult,
                       "API generated wrong url discover popular sorted movie list")
    }

    func testGenerateTopRatedPath() {
        //Arrange
        let goodResult = "https://api.themoviedb.org/3/movie/top_rated?api_key=836b9e978d31e45e403551bf7773f47d&language=ru-RU&page=1"
        let baseUrlParam = API.topRatedBaseUrl
        //Act
        let result = API.listPath(baseUrl: baseUrlParam, page: 1)
        //Assert
        XCTAssertEqual(result.absoluteString, goodResult,
                       "API generated wrong url top rated movie list")
    }

    func testGenerateSearchPath() {
        //Arrange
        let goodResult = "https://api.themoviedb.org/3/search/movie?api_key=836b9e978d31e45e403551bf7773f47d&language=ru-RU&query=Some%20Movie&page=1"
        let queryText = "Some Movie"
        //Act
        let result = API.searchPath(queryText: queryText, page: 1)
        //Assert
        XCTAssertEqual(result.absoluteString, goodResult,
                       "API generated wrong url search movie list")
    }
}
