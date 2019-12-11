//
//  MovieDataHolder.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 05.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

/// Протокол  для хранения даннных модели в буффере контроллере
/// нужен для унификации работы контроллера с данными модели, избежания дулбирования кода
protocol DataHolderProtocol {
    /// Получить буфер данных фильма
    /// служит для передачи данных между модулями
    /// не предназаначен для харанения данных в контроллере
    /// - Returns: модель фильма
    static func getMovie() -> MovieDataModel?

    /// Установить буфер данных фильма для передачи данных между модулями
    ///
    /// - Parameter movie: данные фильма
    static func setMovie(movie: MovieDataModel)

    /// Установить списко данных фильма для использования в буфере контроллера списков
    ///
    /// - Parameters:
    ///   - movies: спсок данных фильмов
    ///   - images: слварь изображений
    func setData(movies: [MovieDataModel], images: [String: UIImage?])

    /// Очистка буфера контроллера
    func resetData()

    /// Получить фильм из буфера
    ///
    /// - Parameter index: индекс фильма для делегата таблицы/коллекции
    /// - Returns: данные фильма
    func getMovie(index: Int) -> MovieDataModel

    /// Полчитть изробаржение из буфера контроллера
    ///
    /// - Parameter path: путь к фильму
    /// - Returns: изображение в формате контроллера
    func getImage(path: String) -> UIImage?

    /// Количество фильмов в буфере контролера
    ///
    /// - Returns: количество фильмов
    func getCount() -> Int

    /// Определяет необходимость подгрузки следующей страницы в буфер контролера
    ///
    /// - Parameter currentIndex: текущий индекс строки делегата таблицы/коллекции
    /// - Returns: нужна ли подгрузка данных
    func needFetch(currentIndex: Int) -> Bool
}

final class DataHolder: DataHolderProtocol {
    private static var movie: MovieDataModel?
    private var movies: [MovieDataModel] = []
    private var images: [String: UIImage?] = [ : ]

    /// Получить переданный фильм
    ///
    /// - Returns: данные фильма
    static func getMovie() -> MovieDataModel? {
        return movie
    }

    /// Передать фильм
    ///
    /// - Parameter movie: данные фильма для передачи
    static func setMovie(movie: MovieDataModel) {
        self.movie = movie
    }

    /// Очистка буфера контроллера
    func resetData() {
        self.movies = []
        self.images = [ : ]
    }

    /// Сохранение данных фильма и изображений в буфер контроллера
    ///
    /// - Parameters:
    ///   - movies: моссив фильмов
    ///   - images: словарь изображений в формате контроллера
    func setData(movies: [MovieDataModel], images: [String: UIImage?]) {
        self.movies += movies
        self.images = self.images.merging(images) { (current, _) in current }
    }

    /// Получить фильм из буфера
    /// для делегатов таблиц/коллекций
    /// - Parameter index: индекс фильма
    /// - Returns: данные фильма
    func getMovie(index: Int) -> MovieDataModel {
        return movies[index]
    }

    /// Получить изобюражение из буфера контролера
    ///
    /// - Parameter path: путь к изображению
    /// - Returns: изображение в формате контроллера
    func getImage(path: String) -> UIImage? {
        guard let image = images[path] else {
            return nil
        }
        return image
    }

    /// Получить количество фильмов в буфере
    ///
    /// - Returns:  количество фильмов в буфере
    func getCount() -> Int {
        return movies.count
    }

    /// Нужна подгрузка следующей страницы?
    ///
    /// - Parameter currentIndex: текущая строка таблицы/элеманта коллекции делегата
    /// - Returns: признак что нужна подгрузка
    func needFetch(currentIndex: Int) -> Bool {
        if currentIndex == movies.count - 1 {
            return true
        }
        return false
    }
}
