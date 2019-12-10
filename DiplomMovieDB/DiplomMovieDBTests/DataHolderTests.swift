//
//  DataHolderTests.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class DataHolderTests: XCTestCase {
    var dataHolder: DataHolderProtocol!
    override func setUp() {
        super.setUp()
        dataHolder = DataHolder()
    }

    override func tearDown() {
        dataHolder = nil
        super.tearDown()
    }

    func testDataHolderCanGetRightCount() {
        //Arrange
        let moviesCount = 3
        let imagesCount = 2
        let movies = TestMovieCreator().createMovies(count: moviesCount)
        let images = createImages(count: imagesCount)
        dataHolder.setData(movies: movies, images: images)
        //Act
        let count = dataHolder.getCount()
        //Assert
        XCTAssertEqual(moviesCount, count, "DataHolder returns wrong count")
    }

    func testDataHolderCanGetMovie() {
        //Arrange
        let validMovieId = 888
        let movieToCheck = TestMovieCreator().createTestMovie(movieId: validMovieId)
        let movieRightIndex = 7
        var movies = TestMovieCreator().createMovies(count: 7)
        let moviesAfter = TestMovieCreator().createMovies(count: 2)
        movies.append(movieToCheck)
        movies += moviesAfter
        dataHolder.setData(movies: movies, images: [ : ])
        //Act
        let gotMovie = dataHolder.getMovie(index: movieRightIndex)
        //Assert
        XCTAssertEqual(gotMovie.movieId, validMovieId, "DataHolder returns wrong movie")
    }

    func testDataHolderCanClearData() {
        //Arrange
        let moviesBefore = 7
        let movies = TestMovieCreator().createMovies(count: moviesBefore)
        dataHolder.setData(movies: movies, images: [ : ])
        XCTAssertEqual(dataHolder.getCount(), moviesBefore, "wrong movie count before test")
        //Act
        dataHolder.resetData()
        //Assert
        XCTAssertEqual(dataHolder.getCount(), 0, "DataHolder don't reset data properly")
    }

    func testDataHolderCanGetImage() {
        //Arrange
        let imagePathToCheck = "/unique_image_path"
        guard let imageToCheck = TestPictureLoader().loadTestImage() else {
            XCTFail("can't load test image")
            return
        }
        let testImage = [imagePathToCheck: imageToCheck]
        dataHolder.setData(movies: [], images: testImage)
        dataHolder.setData(movies: [], images: createImages(count: 3))
        //Act
        let gotImage = dataHolder.getImage(path: imagePathToCheck)
        //Assert
        XCTAssertEqual(gotImage, imageToCheck, "DataHolder got wrong image")
    }

    func testDataHolderDetermineThatNeedFetchData() {
        //Arrange
        let needFetchIndex = 5
        let movies = TestMovieCreator().createMovies(count: needFetchIndex + 1)
        dataHolder.setData(movies: movies, images: [ : ])

        //Act
        let needFetch = dataHolder.needFetch(currentIndex: needFetchIndex)
        //Assert
        XCTAssertTrue(needFetch, "DataHolder determine need fetch data wrong")
    }

    func testDataHolderDetermineThatNeedNoFetchData() {
        //Arrange
        let needFetchIndex = 5
        let movies = TestMovieCreator().createMovies(count: needFetchIndex + 2)
        dataHolder.setData(movies: movies, images: [ : ])
        //Act
        let needFetch = dataHolder.needFetch(currentIndex: needFetchIndex)
        //Assert
        XCTAssertFalse(needFetch, "DataHolder determine need fetch data wrong")
    }

    private func createImages(count: Int) -> [String: UIImage?] {
        let imageData = TestPictureLoader().createPictures(count: count)
        return imageData.mapValues {UIImage(data: $0)}
    }
}
