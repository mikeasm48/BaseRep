//
//  DetailsInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol DetailsInteractorProtocol {
    func loadPictures(posterPath: String, backdropPath: String)
}

class DetailsInteractor: Interactor, DetailsInteractorProtocol {
    var presenter: DetailsPresenterProtocol?

    func loadPictures(posterPath: String, backdropPath: String) {
        self.loadMovieImages(with: [posterPath, backdropPath]) {[weak self] data in
            let poster = data[posterPath]
            let backdrop = data[backdropPath]
            self?.presenter?.setPictures(posterData: poster, backdropData: backdrop)
        }
    }
}
