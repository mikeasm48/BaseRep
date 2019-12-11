//
//  API.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

class API {
/** API Key (v3 auth) */
    private static let apiKey = "836b9e978d31e45e403551bf7773f47d"
/** Примеры запроса с API Key (v3 auth)
1) Один фильм
https://api.themoviedb.org/3/movie/550?api_key=836b9e978d31e45e403551bf7773f47d
2)  Discover (список по популярности - /discover/movie?sort_by=popularity.desc)
https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=836b9e978d31e45e403551bf7773f47d
*/
    private static let dicoverBaseUrl = "https://api.themoviedb.org/3/discover/movie"
    private static let searchBaseUrl = "https://api.themoviedb.org/3/search/movie"
    private static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let topRatedBaseUrl = "https://api.themoviedb.org/3/movie/top_rated"
    static let popularBaseUrl = "https://api.themoviedb.org/3/movie/popular"
    static let upcomingBaseUrl = "https://api.themoviedb.org/3/movie/upcoming"
    static let nowPlayingBaseUrl = "https://api.themoviedb.org/3/movie/now_playing"

    /// URL для загрузки картинки
    ///
    /// - Parameter imagePath: базовая часть URL для загрузки каритнки
    /// - Returns: полный URL загрузки картинки
    static func loadImagePath(imagePath: String) -> URL {
        return URL(string: imageBaseUrl + imagePath)!
    }

    /// URL для загрузки отсортированного списка фильмов
    /// не больше определенной даты релиза (предполагается - текущей)
    /// - Parameters:
    ///   - sortBy: сортировка
    ///   - maxReleaseDate: дата релиза, не позже. Нужно для отфильтровки странных данных
    /// с будущими датами и без деталей
    ///   - page: страница загрузки
    /// - Returns: полный URL к данным списка фильмов
    static func discoverPathByYear(sortBy: String, maxReleaseDate: String, page: Int) -> URL {
        guard var components = URLComponents(string: dicoverBaseUrl) else {
            return URL(string: dicoverBaseUrl)!
        }
        let sortBy = URLQueryItem(name: "sort_by", value: sortBy)
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let lang = URLQueryItem(name: "language", value: "ru-RU")
        let year =  URLQueryItem(name: "release_date.lte", value: maxReleaseDate)
        let page = URLQueryItem(name: "page", value: String(page))
        components.queryItems = [apiKeyItem, lang, sortBy, year, page]
        return components.url!
    }

    /// Произвольный список
    /// может быть использован с любой static константой (перечисленны выше в начале)
    /// в текущей реализации используется в  модуле самых поплярных с topRatedBaseUrl
    /// содеражние легко изменяется другой константой
    /// - Parameters:
    ///   - baseUrl: базовая часть URL списка (см. константы)
    ///   - page: страница подгрузки
    /// - Returns:  полный URL к данным списка фильмов
    static func listPath(baseUrl: String, page: Int) -> URL {
        guard var components = URLComponents(string: baseUrl) else {
            return URL(string: dicoverBaseUrl)!
        }
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let lang = URLQueryItem(name: "language", value: "ru-RU")
        let page = URLQueryItem(name: "page", value: String(page))
        components.queryItems = [apiKeyItem, lang, page]
        return components.url!
    }

    /// Списко поиска по запросу пользователя
    ///
    /// - Parameters:
    ///   - queryText: текст запроса (обычно часть имени фильма). Можно как на русском так и на английском
    ///   - page: страница отображения
    /// - Returns: полный URL к данным списка фильмов по результату запроса
    static func searchPath(queryText: String, page: Int) -> URL {
        guard var components = URLComponents(string: searchBaseUrl) else {
            return URL(string: searchBaseUrl)!
        }
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let lang = URLQueryItem(name: "language", value: "ru-RU")
        let query = URLQueryItem(name: "query", value: queryText)
        let page = URLQueryItem(name: "page", value: String(page))
        components.queryItems = [apiKeyItem, lang, query, page]
        return components.url!
    }
}
