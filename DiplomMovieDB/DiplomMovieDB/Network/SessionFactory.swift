//
//  SessionFactory.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

class SessionFactory {
    private static let  defaultSession = createDefaultSession()
    private static func createDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
    
    static func getDefaultSession() -> URLSession {
        return defaultSession
    }
}
