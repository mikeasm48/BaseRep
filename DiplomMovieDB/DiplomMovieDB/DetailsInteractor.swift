//
//  DetailsInteractor.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation
import CoreData

protocol DetailsInteractorProtocol {
    func loadPictures(posterPath: String, backdropPath: String)
    func saveMovie(movie: MovieDataModel)
    func checkMovieSaved(movie: MovieDataModel)
    func deleteSavedMovie(movie: MovieDataModel)
}

class DetailsInteractor: Interactor, DetailsInteractorProtocol {
    var presenter: DetailsPresenterProtocol?

    func loadPictures(posterPath: String, backdropPath: String) {
        self.loadMovieImages(with: [posterPath, backdropPath]) {[weak self] data in
            let poster = data[posterPath]
            let backdrop = data[backdropPath]
            self?.presenter?.setPictures(posterData: poster, backdropData: backdrop)
        }
    }

    //Сохраняем данные в CoreData
    func saveMovie(movie: MovieDataModel) {
        CoreDataStack.shared.persistentContainer.performBackgroundTask { (context) in
            guard let dataBackdrop = self.dataModel?.getPicture(for: movie.backdropPath) as NSData? else {
                return
            }
            guard let dataPoster = self.dataModel?.getPicture(for: movie.posterPath) as NSData? else {
                return
            }
            let dataObject = MOMovieContent(context: context)
            dataObject.movieId = String(movie.movieId)
            dataObject.title = movie.title
            dataObject.overview = movie.overview
            dataObject.releaseDate = movie.releaseDate
            dataObject.backdropImage = dataBackdrop
            dataObject.posterImage = dataPoster
            do {
                try context.save()
            } catch {
                fatalError("CoreData: failed to save context: \(error)")
            }
            self.returnMovieSavedState(true)
            print("CoreData: saved")
        }
    }

    func checkMovieSaved(movie: MovieDataModel) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
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
            presenter?.setMovieSavedState(fetchedCount > 0)
        } catch {
            print("CoreData: failed to load context Image for filter movieId = \(movie.movieId))")
            presenter?.setMovieSavedState(false)
        }
    }

    func deleteSavedMovie(movie: MovieDataModel) {
        let context = CoreDataStack.shared.persistentContainer.newBackgroundContext()
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

    private func returnMovieSavedState (_ state: Bool) {
        DispatchQueue.main.sync {
            presenter?.setMovieSavedState(state)
        }
    }
}
