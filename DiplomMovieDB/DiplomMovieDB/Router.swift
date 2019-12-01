//
//  CoordinatorProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import Foundation

protocol RouterProtocol {
    func getDefaultModule() -> ModuleProtocol
    func showDetails()
}

class Router: RouterProtocol {
    static let shared = Router()
    var mainModule: ModuleProtocol?

    private init() {}

    func getDefaultModule() -> ModuleProtocol {
        guard let defaultModule = mainModule else {
            let defaultModule = MainModule().buildModule()
            self.mainModule = defaultModule
            return defaultModule
        }
        return defaultModule
    }

    func showDetails() {
        let detailsModule = DetailsModule().buildModule()
        guard let detailsViewController = detailsModule.getView() else {
            return
        }
        mainModule?.getNavigationController()?.pushViewController(detailsViewController, animated: false)
    }
}

extension Router: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
