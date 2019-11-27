//
//  MovieModel.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

struct MovieListItemModel {
    let movieId: Int
    let imdbId: String
    let backdropPath: String
    let posterPath: String
    let originalTitle: String
    let homePage: String
    let overview: String
}

struct MovieViewModel {
    let description: String
    let image: UIImage
}
