//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol InteractorProtocol {
    func loadMovieList(url: URL, completion: @escaping ([MovieDataModel]) -> Void)
    func loadMovieImages(with names: [String],
                                 completion: @escaping ([String: Data]) -> Void)
}

class Interactor: InteractorProtocol {
    
    let networkService: NetworkServiceInput
    var dataModel: DataModelProtocol?
    var fetchData: FetchData?

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }

    func loadMovieList(url: URL, completion: @escaping ([MovieDataModel]) -> Void) {
        networkService.getData(at: url) { data in
            guard let data = data else {
                return
            }
            let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .init()) as? [String: Any]
            guard let response = responseDictionary,
                let resultsArray = response["results"] as? [[String: Any]] else {
                    return
            }

            let resultFetchData = self.mapFetchData(dictionary: response)

            let models = resultsArray.map { (object) -> MovieDataModel in
                let movieId = object["id"] as? Int ?? -1
                let title = object["title"] as? String ?? ""
                let backdropPath = object["backdrop_path"] as? String ?? ""
                let posterPath = object["poster_path"] as? String ?? ""
                let overview = object["overview"] as? String ?? ""
                let releaseDate = object["release_date"] as? String ?? ""
                return MovieDataModel(movieId: movieId,
                                      backdropPath: backdropPath,
                                      posterPath: posterPath,
                                      title: title,
                                      overview: overview,
                                      releaseDate: releaseDate)
            }
            self.setFetchData(fetchData: resultFetchData)
            completion(models)
        }
    }

    func loadMovieImages(with names: [String],
                         completion: @escaping ([String: Data]) -> Void) {
        var pictures: [String: Data] = [ : ]
        let group = DispatchGroup()
        for imageName in names {
            guard let image = dataModel?.getPicture(for: imageName) else {
                group.enter()
                self.loadImageData(imagePath: imageName) { [weak self] image in
                    guard let image = image else {
                        group.leave()
                        return
                    }
                    pictures.updateValue(image, forKey: imageName)
                    self?.dataModel?.updatePicture(for: imageName, data: image)
                    group.leave()
                }
                continue
            }
            pictures.updateValue(image, forKey: imageName)
        }

        group.notify(queue: DispatchQueue.main) {
            completion(pictures)
        }
    }

    private func loadImageData(imagePath: String, completion: @escaping (Data?) -> Void) {
        let url = API.loadImagePath(imagePath: imagePath)
        networkService.getData(at: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
    
    func getNextFetchPage() -> Int {
        guard let fetchData = self.fetchData else {
            print("empty fetch data, return page = 1")
            return 1
        }
        let returnValue = fetchData.currentPage + 1
        print("fetch page = \(returnValue) from \(fetchData.totalPages)")
        return returnValue
    }
    
    private func setFetchData(fetchData: FetchData) {
        self.fetchData = fetchData
    }

    
    private func getFetchedInt(named: String, from: [String: Any]) -> Int {
        guard let resultAny = from[named] else {
            return 0
        }
        switch resultAny {
        case let value as Int:
            return value
        default:
            return 0
        }
    }
    private func mapFetchData(dictionary: [String: Any]) -> FetchData {
        let page = getFetchedInt(named: "page", from: dictionary)
        let totalPages = getFetchedInt(named: "total_pages", from: dictionary)
        let totalResults = getFetchedInt(named: "total_pages", from: dictionary)
        return FetchData(currentPage: page, totalPages: totalPages, totalResults: totalResults)
    }
}
