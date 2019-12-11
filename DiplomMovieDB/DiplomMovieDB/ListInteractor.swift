//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import  Foundation

/// Протокол интерактора модуля последних поступлений
protocol ListInteractorProtocol: ModuleInteractorProtocol {
}

/// Интерактор модуля последних поступлений
class ListInteractor: Interactor, ListInteractorProtocol {
    var presenter: ListPresenterProtocol?

    /// Загрузка данных фильмов
    func loadDataAsync() {
        let url = API.discoverPathByYear(sortBy: "popularity.desc",
                                         maxReleaseDate: getCurrentReleaseDate(),
                                         page: getNextFetchPage())
        loadMovieList(url: url) { [weak self] models in
            self?.loadImages(models: models)
        }
    }

    /// Загрузка изображений
    /// - Parameter models: данные фильмов, для которых загружаются изображения
    private func loadImages(models: [MovieDataModel]) {
        let names = models.map {model in model.posterPath}
        self.loadMovieImages(with: names) {[weak self] data in
            self?.presenter?.presentData(data: models, imageData: data)
        }
    }

    // MARK: - Private methods
    private func getCurrentReleaseDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: currentDate)
    }
}
