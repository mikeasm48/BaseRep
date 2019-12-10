//
//  CoreDataStack.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 07.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation
import CoreData

/// Протокол инициализации стека CoreData
protocol CoreDataStackProtocol {
    var persistentContainer: NSPersistentContainer {get}
}

/// Инициализация стека CoreData
internal final class CoreDataStack: CoreDataStackProtocol {
    var persistentContainer: NSPersistentContainer

    init() {
        let group = DispatchGroup()
        persistentContainer = NSPersistentContainer(name: "MovieCoreData")
        group.enter()
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            group.leave()
        }
        group.wait()
    }
}
