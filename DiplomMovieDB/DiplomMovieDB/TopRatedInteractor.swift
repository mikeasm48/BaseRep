//
//  TopRatedInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol TopRatedInteractorProtocol {
    func loadDataAsync()
}

class TopRatedInteractor: Interactor, TopRatedInteractorProtocol {
    var presenter: TopRatedPresenterProtocol?

    func loadDataAsync() {
        let url = API.discoverPath(sortBy: "popularity.desc",
                                   page: DataModel.shared.getNextFetchPage(list: ListType.topRated))

        loadMovieList(list: ListType.topRated, url: url) { [weak self] (models) in
            self?.loadImages(with: models.map{model in model.posterPath})
        }
    }

    private func loadImages(with names: [String]){
        self.loadMovieImages(with: names) { [weak self] in
            self?.presenter?.reloadData()
        }
    }
}
