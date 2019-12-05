//
//  TopRatedInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol TopRatedInteractorProtocol {
    func loadDataAsync(list: ListType)
}

class TopRatedInteractor: Interactor, TopRatedInteractorProtocol {
    var presenter: TopRatedPresenterProtocol?

    func loadDataAsync(list: ListType) {
        let url = API.discoverPath(sortBy: "popularity.desc",
                                   page: DataModel.shared.getNextFetchPage(list: list))
        loadMovieList(list: list, url: url) { [weak self] models in
            self?.loadImages(models: models)
        }
    }

    private func loadImages(models: [MovieDataModel]) {
        let names = models.map {model in model.backdropPath}
        self.loadMovieImages(with: names) {[weak self] data in
            self?.presenter?.reloadData(data: models, imageData: data)
        }
    }
}
