//
//  ModuleViewControllerSpy.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class TableViewControllerSpy: TableViewControllerProtocol {
    var movies: [MovieDataModel] = []
    var images: [String: UIImage?] = [ : ]
    var expect: XCTestExpectation?

    func loadData() {
        //Stub
    }

    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        self.movies = movies
        self.images = images
        expect?.fulfill()
    }

    func selectRow(indexPath: IndexPath) {
        //Stub
    }

    func fetchData() {
        //Stub
    }
}
