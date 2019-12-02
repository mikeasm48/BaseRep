//
//  DetailsRouter.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 02.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
import UIKit

protocol DetailsRouterProtocol {
}

final class DetailsRouter: DetailsRouterProtocol {
    weak var viewController: (DetailsViewControllerProtocol & UIViewController)?
}
