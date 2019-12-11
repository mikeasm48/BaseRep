//
//  ModuleRouterProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 08.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

/// Протокол роутера модуля, расширяется в модуле
protocol ModuleRouterProtocol {
    /// Метод вызова детальной информации из списка
    /// - Parameter movie: модель фильма
    func openDetails(movie: MovieDataModel)
}
