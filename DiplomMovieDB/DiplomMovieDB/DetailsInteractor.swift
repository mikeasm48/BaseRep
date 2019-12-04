//
//  DetailsInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol DetailsInteractorProtocol {
    func showData ()
}

class DetailsInteractor: DetailsInteractorProtocol {
    var presenter: DetailsPresenterProtocol?
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }

    func showData() {
        //
    }
}
