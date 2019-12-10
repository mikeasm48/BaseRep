//
//  Presenter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Пртокол презентера модуля последних поступлений
protocol ListPresenterProtocol: ModulePresenterProtocol {
}

/// Презентер модуля последних поступлений
class ListPresenter: ListPresenterProtocol {
    var viewController: ListViewControllerProtocol?

    /// Передает данные от интерактора контроллеру
    /// перобразует изображения в формат контроллера
    /// - Parameters:
    ///   - data: данные фильмов
    ///   - imageData: изображения для преобразования
    func presentData (data: [MovieDataModel], imageData: [String: Data]) {
        viewController?.didLoadData(movies: data, images: imageData.mapValues {UIImage(data: $0)})
    }
}
