//
//  SearchInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol {
    func search(text: String)
//    func fetch()
}

class SearchInteractor: Interactor, SearchInteractorProtocol {
    var presenter: SearchPresenterProtocol?

    func search(text: String) {
        let url = API.searchPath(queryText: text, page: 1)
        loadMovieList(url: url) { [weak self] models in
            self?.loadImages(models: models)
        }
    }

    private func loadImages(models: [MovieDataModel]) {
        let names = models.map {model in model.posterPath}
        self.loadMovieImages(with: names) {[weak self] data in
            self?.presenter?.presentData(data: models, imageData: data)
        }
    }
}
