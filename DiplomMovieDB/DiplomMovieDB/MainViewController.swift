//
//  MainViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
/// Протокол контроллера главного модуля
protocol MainViewControllerProtocol {
}

/// Контроллер главного модуля
class MainViewController: UIViewController, MainViewControllerProtocol {

    var router: MainRouterProtocol?
    var topRatedViewController: UIViewController?
    var recentListViewController: UIViewController?

    private var needSplash = true

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needSplash {
            needSplash = false
            showSplashScreen()
        }
    }

    /// Отображем элементы модулей, входящих в общую сборку
    private func showModule() {
        view.backgroundColor = .white
        navigationItem.title = "Популярные"
        guard let top = topRatedViewController else {
            return
        }

        guard let list = recentListViewController else {
            return
        }
        addChild(top)
        view.addSubview(top.view)
        addChild(list)
        view.addSubview(list.view)

        top.view.translatesAutoresizingMaskIntoConstraints = false
        list.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //TopRated
            top.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            top.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            top.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            top.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                             constant: view.frame.height / 3),
            //List
            list.view.topAnchor.constraint(equalTo: top.view.bottomAnchor),
            list.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            list.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            list.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
  // MARK: - Private methods

    /// Отображаем заставку при старте приложения на 2 секунды
    /// параллельно грузим данные двух частей главного модуля
    private func showSplashScreen() {
        let splashScreenController = UIViewController()
        splashScreenController.view.backgroundColor = .black
        let logoImage = UIImage(named: "LogoMovieDB")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .center
        logoImageView.frame = splashScreenController.view.frame
        splashScreenController.view.addSubview(logoImageView)

        self.present(splashScreenController, animated: false, completion: nil)
        self.showModule()
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            DispatchQueue.main.sync {
                splashScreenController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
