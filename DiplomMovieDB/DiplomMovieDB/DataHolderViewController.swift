//
//  MovieListViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 05.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

/// Контроллер с буфером
class DataHolderViewController: UIViewController {
    /// Буфер, устанавливается в ассемблере модуля
    var dataHolder: DataHolderProtocol?

    /// Получить буфер
    ///
    /// - Returns: возвращает буфер котнтролера
    func getDataHolder() -> DataHolderProtocol {
        guard let dataHolder = self.dataHolder else {
            return DataHolder()
        }
        return dataHolder
    }
}
