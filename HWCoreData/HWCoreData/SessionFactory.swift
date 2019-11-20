//
//  SessionFactory.swift
//  HWCoreData
//
//  Created by Михаил Асмаковец on 20.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class SessionFactory {
    func createDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
}
