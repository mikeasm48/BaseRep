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
    var expect: XCTestExpectation?

    func setPictures(posterData: Data?, backdropData: Data?) {
        //
    }

    func setMovieSavedState(_ state: Bool) {
        presentedState = state
        expect?.fulfill()
    }
}
