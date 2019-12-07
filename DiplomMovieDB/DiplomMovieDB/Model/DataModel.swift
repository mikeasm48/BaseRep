//
//  DataModel.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 04.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

struct MovieDataModel {
    let movieId: Int
    let backdropPath: String
    let posterPath: String
    let title: String
    let overview: String
    let releaseDate: String
}

struct FetchData {
    let currentPage: Int
    let totalPages: Int
    let totalResults: Int
}

protocol DataModelProtocol {
    func updatePicture(for name: String, data: Data)
    func isPictureLoaded(for name: String) -> Bool
    func getPicture(for name: String) -> Data?
}
final class DataModel: DataModelProtocol {
    static let shared = DataModel()
    private var pictures: [String: Data] = [ : ]

    private let queue = DispatchQueue(label: "com.dm.barrier",
                                      qos: .unspecified,
                                      attributes: .concurrent,
                                      autoreleaseFrequency: .never,
                                      target: nil)

    private init() {}

    //Model interface
    func updatePicture(for name: String, data: Data) {
        queue.async(flags: .barrier) {
            self.pictures.updateValue(data, forKey: name)
        }
    }


    func isPictureLoaded(for name: String) -> Bool {
        if getPicture(for: name) == nil {
            return false
        }
        return true
    }

    func getPicture(for name: String) -> Data? {
        var results: Data?
        queue.sync {
            results = pictures[name]
        }
        return results
    }
}

extension DataModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
