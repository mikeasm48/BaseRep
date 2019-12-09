//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import  Foundation

protocol ListInteractorProtocol: ModuleInteractorProtocol {
}

class ListInteractor: Interactor, ListInteractorProtocol {
    var presenter: ListPresenterProtocol?

    func loadDataAsync() {
        let url = API.discoverPathByYear(sortBy: "popularity.desc", maxReleaseDate: getCurrentReleaseDate(), page: getNextFetchPage())
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

    private func getCurrentReleaseDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: currentDate)
    }
}
