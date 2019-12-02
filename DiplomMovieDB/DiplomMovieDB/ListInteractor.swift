//
//  Interactor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

//protocol ListInteractorInput {
//    func loadImage(imageName: String, completion: @escaping (UIImage?) -> Void)
//    func loadDiscoverMovieList(sortBy: String, completion: @escaping ([MovieDataModel]) -> Void)
//}

import  Foundation

protocol ListInteractorProtocol {
    func loadDataAsync()
}

class ListInteractor: ListInteractorProtocol {
    var presenter: ListPresenterProtocol?
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }

    func loadDataAsync() {
        loadDiscoverMovieList(sortBy: "popularity.desc") { [weak self] models in
            //self?.loadMovieBackdropImages(with: models)
            self?.loadMoviePosterImages(with: models)
        }
    }

    private func loadMovieBackdropImages(with models: [MovieDataModel]) {
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
           self.presenter?.reloadData(data: resultModel)
        }
    }
    
    private func loadMoviePosterImages(with models: [MovieDataModel]) {
        var resultModel: [ListMovieImageDataModel] = []
        
        let group = DispatchGroup()
        for model in models {
            group.enter()
            self.loadImageData(imagePath: model.posterPath) { [weak self] image in
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
            self.presenter?.reloadData(data: resultModel)
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

    private func loadDiscoverMovieList(sortBy: String, completion: @escaping ([MovieDataModel]) -> Void) {
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
            completion(models)
        }
    }
}
