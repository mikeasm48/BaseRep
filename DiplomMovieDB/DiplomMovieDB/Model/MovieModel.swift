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

struct FetchData {
    let currentPage: Int
    let totalPages: Int
    let totalResults: Int
}

struct MovieListHolder {
    let fetchData: FetchData
    let movies: [ListMovieModel]
}

protocol MovieModelProtocol {
    //List
    func getMovies() -> [ListMovieModel]
    func setMovies(fetchData: FetchData, list: [ListMovieModel])
    func moviesCount() -> Int
    func getMoviesFetchData() -> FetchData
    //TopRated
    func getTopRated() -> [ListMovieModel]
    func setTopRated(fetchData: FetchData, list: [ListMovieModel])
    func getTopRatedFetchData() -> FetchData
}

final class MovieModel: MovieModelProtocol {
    static let shared = MovieModel()
    //private var movies: [ListMovieModel] = []

    private var movies: MovieListHolder
    private var topRated: MovieListHolder

    private init() {
        let fetchData = FetchData(currentPage: 0, totalPages: 0, totalResults: 0)
        let list: [ListMovieModel] = []
        self.movies = MovieListHolder(fetchData: fetchData, movies: list)

        self.topRated = self.movies
    }

    //Movies
    func setMovies(fetchData: FetchData, list: [ListMovieModel]) {
        self.movies = MovieListHolder(fetchData: fetchData, movies: self.movies.movies + list)
    }

    func getMovies() -> [ListMovieModel] {
        return self.movies.movies
    }

    func moviesCount() -> Int {
        return self.movies.movies.count
    }

    func getMoviesFetchData() -> FetchData {
        return self.movies.fetchData
    }

    func getTopRatedFetchData() -> FetchData {
        return self.topRated.fetchData
    }

    //TopRated
    func setTopRated(fetchData: FetchData, list: [ListMovieModel]) {
        self.topRated = MovieListHolder(fetchData: fetchData, movies: self.topRated.movies + list)
    }

    func getTopRated() -> [ListMovieModel] {
        return self.topRated.movies
    }
}

extension MovieModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
