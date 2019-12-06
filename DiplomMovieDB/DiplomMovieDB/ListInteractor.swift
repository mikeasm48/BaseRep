//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import  Foundation

protocol ListInteractorProtocol {
    func loadDataAsync()
}

class ListInteractor: Interactor, ListInteractorProtocol {
    var presenter: ListPresenterProtocol?
    
    func loadDataAsync() {
        // Шакальские без картинок и описаний, для отладки
        //         let url = API.discoverPath(sortBy: "release_date.desc",
        //                                    page: getNextFetchPage())
        let url = API.discoverPath(sortBy: "popularity.desc",
                                   page: getNextFetchPage())
        loadMovieList(url: url) { [weak self] models in
            self?.loadImages(models: models)
        }
    }

    private func loadImages(models: [MovieDataModel]) {
        let names = models.map {model in model.posterPath}
        self.loadMovieImages(with: names) {[weak self] data in
            self?.presenter?.reloadData(data: models, imageData: data)
        }
    }
}
