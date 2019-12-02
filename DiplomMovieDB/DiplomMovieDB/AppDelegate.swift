//
//  AppDelegate.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        //let viewController = Router.shared.getDefaultModule().getView()
        let viewController = ListAssembly.build()
        window?.rootViewController = viewController.navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
