//
//  TopRatedInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

/// Протокол интерактора модуля популярных фильмов
protocol TopRatedInteractorProtocol: ModuleInteractorProtocol {
}

/// Интерактор модуля популярных фильмов
class TopRatedInteractor: Interactor, TopRatedInteractorProtocol {
    var presenter: TopRatedPresenterProtocol?

    /// Начальная загрузка данных
    func loadDataAsync() {
        let url = API.listPath(baseUrl: API.topRatedBaseUrl, page: 1)
        loadMovieList(url: url) { [weak self] models in
            self?.loadImages(models: models)
        }
    }

    // MARK: - Private methods
    private func loadImages(models: [MovieDataModel]) {
        let names = models.map {model in model.backdropPath}
        self.loadMovieImages(with: names) {[weak self] data in
            self?.presenter?.presentData(data: models, imageData: data)
        }
    }
}
