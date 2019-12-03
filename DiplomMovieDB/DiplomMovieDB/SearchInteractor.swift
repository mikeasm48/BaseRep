//
//  SearchInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol {
    
}

class SearchInteractor: SearchInteractorProtocol {
    var presenter: SearchPresenterProtocol?
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }
}
