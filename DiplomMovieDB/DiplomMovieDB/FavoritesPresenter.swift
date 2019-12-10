//
//  FavoritesPresenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол презентера модуля сохраненных в избранном фильмов
protocol FavoritesPresenterProtocol: ModulePresenterProtocol {
}
/// Презентер модуля сохраненных в избранном фильмов
class FavoritesPresenter: FavoritesPresenterProtocol {
    var viewController: FavoritesViewControllerProtocol?

    /// Получает аднные от интерактора, преобразует изображения в формат контроллера
    ///
    /// - Parameters:
    ///   - data: данные фильмов
    ///   - imageData: изображения для преобразования
    func presentData(data: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: data, images: imageData.mapValues {UIImage(data: $0)})
    }
}
