//
//  MOMovieContent.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 07.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//


import  Foundation
import CoreData

@objc(MOMovieContent)
internal class MOMovieContent: NSManagedObject {
    @NSManaged var movieId: String
    @NSManaged var title: String
    @NSManaged var overview: String
    @NSManaged var releaseDate: String
    @NSManaged var posterImage: NSData
    @NSManaged var backdropImage: NSData
    
}
