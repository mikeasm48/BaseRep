//
//  DetailsViewControllerSpy.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class DetailsViewControllerSpy: DetailsViewControllerProtocol {
    var posterImage: UIImage?
    var backdropImage: UIImage?
    var movieSavedStated: Bool?
    
    var expect: XCTestExpectation?
    
    func didShowDetails(poster: UIImage?, backdrop: UIImage?) {
        self.posterImage = poster
        self.backdropImage = backdrop
        expect?.fulfill()
    }

    func didCheckCoreDataState(_ saved: Bool) {
        self.movieSavedStated = saved
        expect?.fulfill()
    }
}
