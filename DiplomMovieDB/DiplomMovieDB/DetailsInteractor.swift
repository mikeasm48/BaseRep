//
//  DetailsInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation
import CoreData
/// Протокол интерактора модуля отображения деталей фильма
protocol DetailsInteractorProtocol {
    func loadDetails(movie: MovieDataModel)
    func saveMovie(movie: MovieDataModel)
    func deleteSavedMovie(movie: MovieDataModel)
}
/// Интерактор модуля отображения деталей фильма
class DetailsInteractor: Interactor, DetailsInteractorProtocol {
    var presenter: DetailsPresenterProtocol?
    let coreDataStack: CoreDataStackProtocol

    init(networkService: NetworkServiceInput, coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
        super.init(networkService: networkService)
    }
    
    /// Загрузка деталей
    ///загружаются только картинки, при возможности - уже сохраненные в модели данных
    ///если в модели нет, тогда идем в сеть
    /// - Parameter movie: <#movie description#>
    func loadDetails(movie: MovieDataModel) {
        let savedState = getMovieSavedState(movie: movie)
        self.loadMovieImages(with: [movie.posterPath, movie.backdropPath]) {[weak self] data in
            let poster = data[movie.posterPath]
            let backdrop = data[movie.backdropPath]
            self?.presenter?.setDetails(posterData: poster, backdropData: backdrop, savedState: savedState)
        }
    }

    /// Сохраняем данные избранного фильма в CoreData
    ///созхраняем с картинками, картинки берем кэшированные из модели
    /// - Parameter movie: данные фильма
    func saveMovie(movie: MovieDataModel) {
        coreDataStack.persistentContainer.performBackgroundTask { (context) in
            guard let dataBackdrop = self.dataModel?.getPicture(for: movie.backdropPath) as NSData? else {
                return
            }
            guard let dataPoster = self.dataModel?.getPicture(for: movie.posterPath) as NSData? else {
                return
            }
            let movieContent = NSEntityDescription.insertNewObject(forEntityName: "MovieContent", into: context) as? MOMovieContent
            guard let dataObject = movieContent else {
                return
            }
            dataObject.movieId = String(movie.movieId)
            dataObject.title = movie.title
            dataObject.overview = movie.overview
            dataObject.releaseDate = movie.releaseDate
            dataObject.backdropImage = dataBackdrop
            dataObject.posterImage = dataPoster
            dataObject.posterPath = movie.posterPath
            dataObject.backdropPath = movie.backdropPath
            do {
                try context.save()
            } catch {
                fatalError("CoreData: failed to save context: \(error)")
            }
            self.returnMovieSavedState(true)
            print("CoreData: saved")
        }
    }

    /// Удалем сохраненный в избранном фильм
    ///
    /// - Parameter movie: данные фильма
    func deleteSavedMovie(movie: MovieDataModel) {
        let context = coreDataStack.persistentContainer.newBackgroundContext()
        let fetchRequest = NSFetchRequest<MOMovieContent>(entityName: "MovieContent")
        var deletedCount = 0
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                if result.movieId == String(movie.movieId) {
                        deletedCount += 1
                        context.delete(result)
                    }
            }
            do {
                try context.save()
                print("CoreData: removed \(deletedCount) from \(results.count)")
                presenter?.setMovieSavedState(false)
            } catch {
                fatalError("CoreData: failed to save context for remove: \(error)")
            }
        } catch {
            print("CoreData: failed to get images list for delete")
        }
    }

 // MARK: - детали реализации

    private func getMovieSavedState(movie: MovieDataModel) -> Bool {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MOMovieContent>(entityName: "MovieContent")
        let sortBySearchTag = NSSortDescriptor(key: "movieId", ascending: true)
        fetchRequest.sortDescriptors = [sortBySearchTag]
        fetchRequest.predicate = NSPredicate(format: "movieId = %@", String(movie.movieId))
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        do {
            try controller.performFetch()
            let fetchedCount = controller.fetchedObjects?.count ?? 0
            print("CoreData: fetched \(fetchedCount)")
            return (fetchedCount > 0)
        } catch {
            print("CoreData: failed to load context Image for filter movieId = \(movie.movieId))")
            return false
        }
    }

    private func returnMovieSavedState (_ state: Bool) {
        DispatchQueue.main.sync {
            presenter?.setMovieSavedState(state)
        }
    }
}
