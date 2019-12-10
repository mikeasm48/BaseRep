//
//  NetworkService.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

/// Получения данных по  URL
/// используется интеракторами
protocol NetworkServiceInput {
    func getData(at path: URL, completion: @escaping (Data?) -> Void)
}

/// Реализация доступа к данным
class NetworkService: NetworkServiceInput {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    /// Получает данные для интеракторов
    ///
    /// - Parameters:
    ///   - path:    URL к данным
    ///   - completion: данные JSON для маппинга на модель
    func getData(at path: URL, completion: @escaping (Data?) -> Void) {
        let dataTask = session.dataTask(with: path) { data, _, _ in
            completion(data)
        }
        dataTask.resume()
    }
}
