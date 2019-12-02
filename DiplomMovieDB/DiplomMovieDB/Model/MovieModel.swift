//
//  MovieModel.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

struct MovieDataModel {
    let movieId: Int
    let imdbId: String
    let backdropPath: String
    let posterPath: String
    let originalTitle: String
    let homePage: String
    let overview: String
}

struct ListMovieImageDataModel {
    let movie: MovieDataModel
    let image: Data
}

struct ListMovieModel {
    let movie: MovieDataModel
    let image: UIImage
}

struct DetailsMovieModel {
    let movie: MovieDataModel
    let posterImage: UIImage
    let backdropImage: UIImage
}

protocol MovieModelProtocol {
    func getMovies() -> [ListMovieModel]
    func setMovies(list: [ListMovieModel])
    func moviesCount() -> Int
}

final class MovieModel: MovieModelProtocol{
    static let shared = MovieModel()
    private var movies: [ListMovieModel] = []

    private init() {}

    func setMovies(list: [ListMovieModel]){
        movies = list
    }

    func getMovies() -> [ListMovieModel] {
        return movies
    }
    func moviesCount() -> Int {
        return movies.count
    }
}

extension MovieModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
