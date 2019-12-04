//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol InteractorProtocol {
    func loadMovieList(url: URL, completion: @escaping (FetchData, [MovieDataModel]) -> Void)
    func loadMoviePosterImages(with models: [MovieDataModel],
                               completion: @escaping ([ListMovieImageDataModel]) -> Void)
    func loadMovieBackdropImages(with models: [MovieDataModel],
                                 completion: @escaping ([ListMovieImageDataModel]) -> Void)
}

class Interactor: InteractorProtocol {
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }

    func loadMovieList(url: URL, completion: @escaping (FetchData, [MovieDataModel]) -> Void) {
        let emptyFetchData = FetchData(currentPage: 0, totalPages: 0, totalResults: 0)
        networkService.getData(at: url) { data in
            guard let data = data else {
                completion(emptyFetchData, [])
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
                let title = object["original_title"] as? String ?? ""
                let imdbId = object["imdb_id"] as? String ?? ""
                let backdropPath = object["backdrop_path"] as? String ?? ""
                let posterPath = object["poster_path"] as? String ?? ""
                let homePage = object["homepage"] as? String ?? ""
                let overview = object["overview"] as? String ?? ""
                return MovieDataModel(movieId: movieId,
                                      imdbId: imdbId,
                                      backdropPath: backdropPath,
                                      posterPath: posterPath,
                                      originalTitle: title,
                                      homePage: homePage,
                                      overview: overview)
            }
            completion(resultFetchData, models)
        }
    }

    func loadMovieBackdropImages(with models: [MovieDataModel],
                                 completion: @escaping ([ListMovieImageDataModel]) -> Void) {
        var resultModel: [ListMovieImageDataModel] = []
        let group = DispatchGroup()
        for model in models {
            group.enter()
            self.loadImageData(imagePath: model.backdropPath) { [weak self] image in
                guard let image = image else {
                    group.leave()
                    return
                }
                let viewModel = ListMovieImageDataModel(movie: model, image: image)
                resultModel.append(viewModel)
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completion(resultModel)
        }
    }

    func loadMoviePosterImages(with models: [MovieDataModel],
                               completion: @escaping ([ListMovieImageDataModel]) -> Void) {
        var resultModel: [ListMovieImageDataModel] = []
        let group = DispatchGroup()
        for model in models {
            group.enter()
            self.loadImageData(imagePath: model.posterPath) { [weak self] image in
                guard let image = image else {
                    completion([])
                    group.leave()
                    return
                }
                let viewModel = ListMovieImageDataModel(movie: model, image: image)
                resultModel.append(viewModel)
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completion(resultModel)
        }
    }
    
    func getNextFetchedPage(fetchData: FetchData?) -> Int {
        guard let page = fetchData?.currentPage else {
            return 1
        }
        return page + 1
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
