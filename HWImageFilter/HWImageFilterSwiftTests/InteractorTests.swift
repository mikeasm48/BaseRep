//
//  InteractorTests.swift
//  HWImageFilterSwiftTests
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import HWImageFilter

class InteractorTests: XCTestCase {
    var interactor: Interactor!
    var networkServiceStub: NetworkServiceStub!
    
    override func setUp() {
        super.setUp()
        networkServiceStub = NetworkServiceStub()
        interactor = Interactor(networkService: networkServiceStub)
    }

    override func tearDown() {
        super.tearDown()
        networkServiceStub = nil
        interactor = nil
    }

    func testThatInteractorCanLoadImage() {
        //Arrange
        //Act
        //Assert
    }

    class NetworkServiceStub: NetworkServiceInput {
        func getData(at path: String, parameters: [AnyHashable : Any]?, completion: @escaping (Data?) -> Void) {
            //
        }
        
        func getData(at path: URL, completion: @escaping (Data?) -> Void) {
            //
        }
    }
}
