//
//  ModulePresenterProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 08.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import Foundation

protocol ModulePresenterProtocol {
    func presentData(data: [MovieDataModel], imageData: [String: Data])
}
