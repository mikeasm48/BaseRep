//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol InteractorInput {
    func loadImage(imageName: String, completion: @escaping (UIImage?) -> Void)
    func loadDiscoverMovieList(sortBy: String, completion: @escaping ([MovieItemModel]) -> Void)
}

protocol InteractorOutput {
   //TODO нужен?
}

class Interactor: InteractorInput {
    //TODO нужен???
    var interactorOutput: InteractorOutput?
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }

    func loadImage(imageName: String, completion: @escaping (UIImage?) -> Void) {
        let url = API.loadImagePath(imageName: imageName)
        networkService.getData(at: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
    }

    func loadDiscoverMovieList(sortBy: String, completion: @escaping ([MovieItemModel]) -> Void) {
        let url = API.discoverPath(sortBy: sortBy)
        networkService.getData(at: url) { data in
            guard let data = data else {
                completion([])
                return
            }
            let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .init()) as? [String: Any]
            guard let response = responseDictionary,
                //let photosDictionary = response["photos"] as? [String: Any],
                let resultsArray = response["results"] as? [[String: Any]] else {
                    completion([])
                    return
            }

            let models = resultsArray.map { (object) -> MovieItemModel in
                let movieId = object["id"] as? Int ?? -1
                let title = object["original_title"] as? String ?? ""
                let imdbId = object["imdb_id"] as? String ?? ""
                let backdropPath = object["backdrop_path"] as? String ?? ""
                let posterPath = object["poster_path"] as? String ?? ""
                let homePage = object["homepage"] as? String ?? ""
                let overview = object["overview"] as? String ?? ""
                return MovieItemModel(movieId: movieId,
                                          imdbId: imdbId,
                                          backdropPath: backdropPath,
                                          posterPath: posterPath,
                                          originalTitle: title,
                                          homePage: homePage,
                                          overview: overview)
            }
            completion(models)
        }
    }
}
