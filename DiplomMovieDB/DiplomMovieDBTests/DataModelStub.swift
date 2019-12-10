//
//  DataModelStub.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
@testable import DiplomMovieDB

class DataModelStub: DataModelProtocol {
    func updatePicture(for name: String, data: Data) {
        //Stub
    }

    func isPictureLoaded(for name: String) -> Bool {
        return true
    }

    func getPicture(for name: String) -> Data? {
        return TestPictureLoader().loadTestPicture()
    }
}
