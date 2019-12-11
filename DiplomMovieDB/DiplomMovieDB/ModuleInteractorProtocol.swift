//
//  InteractorProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 08.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

/// Общий протокол интеракторов
protocol ModuleInteractorProtocol {
    /// Асинхронная загрузка контроллера модуля
    func loadDataAsync()
}
