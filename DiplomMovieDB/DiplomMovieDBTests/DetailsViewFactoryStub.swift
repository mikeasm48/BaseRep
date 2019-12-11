//
//  DetailsViewFactoryStub.swift
//  DiplomMovieDBTests
//
//  Created by Михаил Асмаковец on 11.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
@testable import DiplomMovieDB

class DetailsViewFactoryStub: DetailsViewFactoryProtocol {
    var poster: UIImage?
    func buildDetailsView(movieData: MovieDataModel, poster: UIImage?, backdrop: UIImage?, savedState: Bool) {
        self.poster = poster
    }

    func getPosterForZoom() -> UIImage? {
        return poster
    }

    func getPosterViewForZoom() -> UIImageView {
        return UIImageView(image: poster)
    }

    func getScrollView() -> UIScrollView {
        return UIScrollView()
    }

    func getSaveButton() -> UIButton {
        return UIButton()
    }
}
