//
//  ModuleProtocol.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 30.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit
protocol ModuleProtocol {
    func buildModule() -> ModuleProtocol
    func getView() -> UIViewController?
    func getPresenter() -> PresenterInputProtocol?
    func getNavigationController() -> UINavigationController?
}
