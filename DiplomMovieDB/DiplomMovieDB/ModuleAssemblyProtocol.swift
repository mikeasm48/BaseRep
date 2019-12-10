//
//  AssemblyProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Общий протокол ассемблеров модулей
protocol ModuleAssemblyProtocol {
    /// Сборка модуля
    ///
    /// - Returns: возвращает контроллер модуля
    static func build() -> UIViewController
}
