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

    /**URL для загрузки картинки*/
    static func loadImagePath(imageName: String) -> URL {
        return URL(string: imageBaseUrl + imageName)!
    }

    /**URL для загрузки списка фильмов*/
    static func discoverPath(sortBy: String) -> URL {
        guard var components = URLComponents(string: dicoverBaseUrl) else {
            return URL(string: dicoverBaseUrl)!
        }
        let sortBy = URLQueryItem(name: "sort_by", value: sortBy)
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems = [sortBy, apiKeyItem]
        return components.url!
    }
}
