//
//  FavoritesInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

//import Foundation
import CoreData

protocol FavoritesInteractorProtocol: ModuleInteractorProtocol {
}

class FavoritesInteractor: FavoritesInteractorProtocol {
    var presenter: FavoritesPresenterProtocol?
    let networkService: NetworkServiceInput
    let coreDataStack: CoreDataStackProtocol
    var dataModel: DataModelProtocol?

    init(networkService: NetworkServiceInput, coreDataStack: CoreDataStackProtocol) {
        self.networkService = networkService
        self.coreDataStack = coreDataStack
    }

    func loadDataAsync() {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MOMovieContent>(entityName: "MovieContent")
        var models: [MovieDataModel] = []
        var images: [String: Data] = [ : ]
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                guard let movieId = Int(result.movieId) else {
                    return
                }
                let model = MovieDataModel(movieId: movieId,
                                           backdropPath: result.backdropPath,
                                           posterPath: result.posterPath,
                                           title: result.title,
                                           overview: result.overview,
                                           releaseDate: result.releaseDate)
                models.append(model)
                //Преобразовываем картинки
                guard let backdropImage = result.backdropImage as Data? else {
                    continue
                }
                guard let posterImage = result.posterImage as Data? else {
                    continue
                }
                //Сохраняем в общую модель для использования в других модулях
                dataModel?.updatePicture(for: model.backdropPath, data: backdropImage)
                dataModel?.updatePicture(for: model.posterPath, data: posterImage)
                //Передаем картинки для вовзрата в presenter
                images.updateValue(backdropImage, forKey: model.backdropPath)
                images.updateValue(posterImage, forKey: model.posterPath)
            }
        } catch {
            print("CoreData: failed to get images list")
        }
        presenter?.presentData(data: models, imageData: images)
    }
}
