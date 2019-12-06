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
    private static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let topRatedBaseUrl = "https://api.themoviedb.org/3/movie/top_rated"
    static let popularBaseUrl = "https://api.themoviedb.org/3/movie/popular"
    static let upcomingBaseUrl = "https://api.themoviedb.org/3/movie/upcoming"
    static let nowPlayingBaseUrl = "https://api.themoviedb.org/3/movie/now_playing"

    /**URL для загрузки картинки*/
    static func loadImagePath(imagePath: String) -> URL {
        return URL(string: imageBaseUrl + imagePath)!
    }

    /**URL для загрузки списка фильмов*/
    static func discoverPath(sortBy: String, page: Int) -> URL {
        guard var components = URLComponents(string: dicoverBaseUrl) else {
            return URL(string: dicoverBaseUrl)!
        }
        let sortBy = URLQueryItem(name: "sort_by", value: sortBy)
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let lang = URLQueryItem(name: "language", value: "ru-RU")
        let vote =  URLQueryItem(name: "vote_count.gte", value: "3")
        let year =  URLQueryItem(name: "vote_count.gte", value: "2019")
        let page = URLQueryItem(name: "page", value: String(page))
        components.queryItems = [apiKeyItem, lang, sortBy, vote, year, page]
        return components.url!
    }
    
    //Нужен для отладки, если раскоментить год и vote то получаетс] то же что сортировка
    //по "popularity.desc"
    //без этих фильтров лезет всякая грязь, нужно только для отладки
    static func discoverByReleaseDate(page: Int) -> URL {
        guard var components = URLComponents(string: dicoverBaseUrl) else {
            return URL(string: dicoverBaseUrl)!
        }
        let sortBy = URLQueryItem(name: "sort_by", value: "release_date.desc")
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        let lang = URLQueryItem(name: "language", value: "ru-RU")
//        let vote =  URLQueryItem(name: "vote_count.gte", value: "3")
//        let year =  URLQueryItem(name: "vote_count.gte", value: "2019")
        let page = URLQueryItem(name: "page", value: String(page))
//        components.queryItems = [apiKeyItem, lang, sortBy, vote, year, page]
        components.queryItems = [apiKeyItem, lang, sortBy, page]
        return components.url!
    }

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
}
