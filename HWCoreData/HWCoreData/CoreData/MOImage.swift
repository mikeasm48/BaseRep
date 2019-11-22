//
//  MOImage.swift
//  HWCoreData
//
//  Created by Михаил Асмаковец on 21.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import  Foundation
import CoreData

@objc(MOImage)
internal class MOImage: NSManagedObject {
    @NSManaged var searchTag: String
    @NSManaged var imageDescription: String
    @NSManaged var imageData: NSData
}
