//
//  SearchPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
/// Протокол презентера модуля поиска фильмов
protocol SearchPresenterProtocol: ModulePresenterProtocol {
}
/// Презентер модуля поиска фильмов
class SearchPresenter: SearchPresenterProtocol {
    var viewController: SearchViewControllerProtocol?

    /// Преобразует изображения от интерактора и передает все контроллеру
    ///
    /// - Parameters:
    ///   - data: данные фильмов
    ///   - imageData: изображения
    func presentData(data: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: data,
                                    images: imageData.mapValues {UIImage(data: $0)})
    }
}
