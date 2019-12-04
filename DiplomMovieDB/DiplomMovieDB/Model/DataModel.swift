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

final class DataModel {
    static let shared = DataModel()

    private var movies   : Dictionary<Int,[MovieDataModel]> = [:]
    private var pictures : Dictionary<String,Data> = [:]
    private var lists    : Dictionary<ListType,[Int]> = [:]
//    private var pictures: MovieListHolder
//    private var lists:

    private init() {

    }
}

extension DataModel: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
