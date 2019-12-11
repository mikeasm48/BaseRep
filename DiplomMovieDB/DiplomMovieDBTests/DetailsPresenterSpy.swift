//
//  DetailsPresenterSpy.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class DetailsPresenterSpy: DetailsPresenterProtocol {
    var presentedState: Bool?
    var posterData: Data?
    var backdropData: Data?
    var expect: XCTestExpectation?

    func setDetails(movie: MovieDataModel, posterData: Data?, backdropData: Data?, savedState: Bool) {
        self.posterData = posterData
        self.backdropData = backdropData
        self.presentedState = savedState
        expect?.fulfill()
    }

    func setMovieSavedState(_ state: Bool) {
        presentedState = state
        expect?.fulfill()
    }
}
