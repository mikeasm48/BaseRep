//
//  FavoritesPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol FavoritesPresenterProtocol: ModulePresenterProtocol {
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    var viewController: FavoritesViewControllerProtocol?

    func presentData(data: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: data, images: imageData.mapValues {UIImage(data: $0)})
    }
}
