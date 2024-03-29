//
//  CoreDataStack.swift
//  HWCoreData
//
//  Created by Михаил Асмаковец on 20.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation
import CoreData

internal final class CoreDataStack {
    static let shared: CoreDataStack = {
        let coreDataStack = CoreDataStack()
        return coreDataStack
    }()

    let persistentContainer: NSPersistentContainer

    private init() {
        let group = DispatchGroup()

        persistentContainer = NSPersistentContainer(name: "HWCoreData")
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
