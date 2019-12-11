//
//  ModulePresenterProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 08.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import Foundation

/// Общий протокол презентера модуля
/// может быть расширен в модуле
protocol ModulePresenterProtocol {
    func presentData(data: [MovieDataModel], imageData: [String: Data])
}
