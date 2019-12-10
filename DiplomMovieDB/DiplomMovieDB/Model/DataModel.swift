//
//  DataModel.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 04.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Модель: данные фильма
struct MovieDataModel {
    let movieId: Int
    let backdropPath: String
    let posterPath: String
    let title: String
    let overview: String
    let releaseDate: String
}

/// Структура данных для постраничной подгрузки
struct FetchData {
    let currentPage: Int
    let totalPages: Int
    let totalResults: Int
}

/// Пртокол модели данных
protocol DataModelProtocol {
    
    /// Обновление данных изображений в модели
    ///
    /// - Parameters:
    ///   - name: путь (имя) изображение. Уникальный идентификатор, который используется для загрузки изображения из сети
    ///   - data: данные изображения
    /// - Returns: <#return value description#>
    func updatePicture(for name: String, data: Data)
    
    /// Изобращжение есть в модели
    ///
    /// - Parameter name: путь (имя) изображения
    /// - Returns: изображение уже загружено в модель?
    func isPictureLoaded(for name: String) -> Bool
    
    /// Получаем изображение из модели
    ///
    /// - Parameter name: путь (имя) изображения
    /// - Returns: изображение
    func getPicture(for name: String) -> Data?
}


/// Модель: реализация
final class DataModel: DataModelProtocol {
    static let shared = DataModel()
    private var pictures: [String: Data] = [ : ]

    private let queue = DispatchQueue(label: "com.dm.barrier",
                                      qos: .unspecified,
                                      attributes: .concurrent,
                                      autoreleaseFrequency: .never,
                                      target: nil)

    private init() {}

    // MARK: - Private methods
    
    ///  Обновление данных изображений в модели
    ///
    /// - Parameters:
    ///   - name: путь
    ///   - data: данные
    func updatePicture(for name: String, data: Data) {
        queue.async(flags: .barrier) {
            self.pictures.updateValue(data, forKey: name)
        }
    }

    /// Изображение есть в модели?
    ///
    /// - Parameter name: путь
    /// - Returns: есть?
    func isPictureLoaded(for name: String) -> Bool {
        if getPicture(for: name) == nil {
            return false
        }
        return true
    }

    /// Получение изображения из модели
    ///
    /// - Parameter name: путь
    /// - Returns: изображение
    func getPicture(for name: String) -> Data? {
        var results: Data?
        queue.sync {
            results = pictures[name]
        }
        return results
    }
}

// MARK: - чтобы не копировали синглтон
extension DataModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
