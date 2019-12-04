//
//  DataModel.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 04.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

enum ListType {
    case lastRecent
    case topRated
    case favorites
    case found
}

struct MovieDataModel {
    let movieId: Int
    let imdbId: String
    let backdropPath: String
    let posterPath: String
    let title: String
    let originalTitle: String
    let homePage: String
    let overview: String
}

struct FetchData {
    let currentPage: Int
    let totalPages: Int
    let totalResults: Int
}

final class DataModel {
    static let shared = DataModel()

    private var movies: [Int: MovieDataModel] = [ : ]
    private var pictures: [String: Data] = [ : ]
    private var lists: [ListType: [Int]] = [ : ]
    private var listFetchData: [ListType: FetchData] = [ : ]

    private let queue = DispatchQueue(label: "com.dm.barrier",
                                      qos: .unspecified,
                                      attributes: .concurrent,
                                      autoreleaseFrequency: .never,
                                      target: nil)

    private init() {}
//https://metanit.com/swift/tutorial/2.12.php

    //Model interface
    func updateModel(list: ListType, data: [MovieDataModel], fetchData: FetchData) {
        queue.async(flags: .barrier) {
            self.setFetchData(list: list, fetchData: fetchData)
            self.appendList(list: list, data: data.map {$0.movieId})
            for movie in data {
                self.appendMovie(movieData: movie)
            }
        }
    }

    func updatePicture(for name: String, data: Data) {
        queue.async(flags: .barrier) {
            self.pictures.updateValue(data, forKey: name)
        }
    }

    func getMovie(list: ListType, index: Int) -> MovieDataModel {
        let movies = self.getMovieList(list: list)
        return movies[index]
    }

    func getListCount(list: ListType) -> Int {
            guard let result = lists[list] else {
                return 0
            }
        return result.count
    }

    func isPictureLoaded(for name: String) -> Bool {
        if getPicture(for: name) == nil {
            return false
        }
        return true
    }

    //Picture - private
    func getPicture(for name: String) -> Data? {
        return pictures[name]
    }

    //List FetchData
    func getFetchData(list: ListType) -> FetchData {
        var resultData = FetchData(currentPage: 0, totalPages: 0, totalResults: 0)
        queue.sync {
            guard let fetchData = self.listFetchData[list] else {
                let newFetchData = FetchData(currentPage: 0, totalPages: 0, totalResults: 0)
                self.listFetchData.updateValue(newFetchData, forKey: list)
                resultData = newFetchData
                return
            }
            resultData = fetchData
        }
        return resultData
    }

    func setFetchData(list: ListType, fetchData: FetchData) {
        queue.async(flags: .barrier) {
            self.listFetchData.updateValue(fetchData, forKey: list)
        }
    }

    func getNextFetchPage(list: ListType) -> Int {
        let fetchData = getFetchData(list: list)
        let returnValue = fetchData.currentPage + 1
        print("return fetch = \(returnValue) from \(fetchData.totalPages)")
        return returnValue
    }
    
    func needListFetch(list: ListType, currentRecord: Int) -> Bool{
        let listCount = getListCount(list: list)
        if (currentRecord  == listCount - 1 ) {
            return true
        }
        return false
    }

    //Lists - private
    private func appendList(list: ListType, data: [Int]) {
        guard let listData = lists[list] else {
            lists.updateValue(data, forKey: list)
            return
        }
      lists[list] = listData + data
    }

    private func getMovieList(list: ListType) -> [MovieDataModel] {
        guard let listIds = lists[list] else {
            return []
        }
        var movieList: [MovieDataModel] = []
        //TODO узнать как правильно маппить опционалы (movies[movieId] может быть nil)
        for movieId in listIds {
            guard let movie = movies[movieId] else {
                continue
            }
            movieList.append(movie)
        }
        return movieList
    }

    //Movies - private
    private func appendMovie(movieData: MovieDataModel) {
        movies.updateValue(movieData, forKey: movieData.movieId)
    }
}

extension DataModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
