//
//  FavoritesInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol FavoritesInteractorProtocol {
}

class FavoritesInteractor: FavoritesInteractorProtocol {
    var presenter: FavoritesPresenterProtocol?
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }
}
