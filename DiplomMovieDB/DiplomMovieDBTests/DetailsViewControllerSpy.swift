//
//  DetailsViewControllerSpy.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 10.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import XCTest
@testable import DiplomMovieDB

class DetailsViewControllerSpy: DetailsViewControllerProtocol {
    var posterImage: UIImage?
    var scrollView: UIScrollView?
    var movieSavedStated: Bool?
    var isSaveButtonInit = false

    var expect: XCTestExpectation?

    func didCheckCoreDataState(_ saved: Bool) {
        self.movieSavedStated = saved
        expect?.fulfill()
    }

    func setPosterForZoom(poster: UIImage?, tapView: UIImageView) {
        posterImage = poster
    }

    func setScrollView(scrollView: UIScrollView) {
        self.scrollView = scrollView
    }

    /// Возвращает view
    func getView() -> UIView? {
        //Stub
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }

    /// Инициализирует обработчик кнопки сохранения
    func initSaveButton() {
        self.isSaveButtonInit = true
    }
}
