//
//  CoreDataStackMock.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 09.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
//https://medium.com/swift2go/how-to-test-with-fake-data-on-ios-66dc87bf093e
import Foundation
import CoreData
@testable import DiplomMovieDB

class MockCoreDataStack: CoreDataStackProtocol {
    var persistentContainer: NSPersistentContainer

    init() {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        persistentContainer = NSPersistentContainer(name: "TestingContainer", managedObjectModel: managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { (description, error) in
            precondition(description.type == NSInMemoryStoreType)
        }
        saveDataTestData()
    }

    func saveDataTestData() {
        let context = self.persistentContainer.viewContext
        let movieContent = NSEntityDescription.insertNewObject(forEntityName: "MovieContent", into: context) as? MOMovieContent
        guard let movie = movieContent else {
            print("fail to append MOMovieContent")
            return
        }
        movie.movieId = "123"
        movie.title = "Movie Title"
    }
}
