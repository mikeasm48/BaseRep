//
//  TestMovieCreator.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

@testable import DiplomMovieDB

class TestMovieCreator {
    func createTestMovie(movieId: Int) -> MovieDataModel {
        return MovieDataModel(movieId: movieId,
                              backdropPath: "",
                              posterPath: "",
                              title: "",
                              overview: "",
                              releaseDate: "")
    }

    func createMovies(count: Int) -> [MovieDataModel] {
        var movies: [MovieDataModel] = []
        for counter in 1 ... count {
            movies.append(createTestMovie(movieId: counter))
        }
        return movies
    }
}
