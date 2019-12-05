//
//  MovieDataHolder.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 05.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

protocol MovieDataHolderProtocol {
    func setData(movies: [MovieDataModel], images: [String: UIImage?])
    func getMovie(index: Int) -> MovieDataModel
    func getImage(path: String) -> UIImage?
    func getCount() -> Int
    func needFetch(currentIndex: Int) -> Bool
}

final class MovieDataHolder: MovieDataHolderProtocol {
    private var movies: [MovieDataModel] = []
    private var images: [String: UIImage?] = [ : ]

    func setData(movies: [MovieDataModel], images: [String: UIImage?]) {
        self.movies += movies
        self.images = self.images.merging(images) { (current, _) in current }
    }

    func getMovie(index: Int) -> MovieDataModel {
        return movies[index]
    }

    func getImage(path: String) -> UIImage? {
        guard let image = images[path] else {
            return nil
        }
        return image
    }

    func getCount() -> Int {
        return movies.count
    }

    func needFetch(currentIndex: Int) -> Bool {
        if currentIndex == movies.count - 1 {
            return true
        }
        return false
    }
}
