//
//  FavoritesPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol FavoritesPresenterProtocol {
    func didLoadMovies(movies: [MovieDataModel], imageData: [String: Data])
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    var viewController: FavoritesViewController?
    
    func didLoadMovies(movies: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: movies, images: imageData.mapValues{UIImage(data: $0)})
    }
}
