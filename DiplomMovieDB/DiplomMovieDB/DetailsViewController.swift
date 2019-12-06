//
//  MovieDetailViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol DetailsViewControllerProtocol {
    func showMoviePictures(poster: UIImage?, backdrop: UIImage?)
}

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    var interactor: DetailsInteractorProtocol?
    var router: DetailsRouterProtocol?

    private var movie: MovieDataModel?

    private let backgroundColor = UIColor.black
    private let textColor = UIColor.white
    private let viewShiftY: CGFloat = 30
    private let viewShiftX: CGFloat = 30

    var scrollView = UIScrollView()

    var lastFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
//        scrollView = getScrollView()
//        view.addSubview(scrollView)
        showDetails()
    }

    func showDetails() {
        guard let movieData = MovieDataHolder.getMovie() else {
            return
        }
        self.movie = movieData
        interactor?.loadPictures(posterPath: movieData.posterPath, backdropPath: movieData.backdropPath)
    }

    private func getScrollView () -> UIScrollView {
        let scrollView = UIScrollView(frame: self.view.frame)
        scrollView.isPagingEnabled = false
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 3)
        return scrollView
    }

    private func getFrame() -> CGRect {
        return CGRect( x: 0, y: 0, width: 0, height: 0)
    }

    private func getBackdropImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: getFrame())
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        view.addSubview(imageView)
        //scrollView.addSubview(imageView)
        return imageView
    }

    private func getPosterImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: getFrame())
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        //scrollView.addSubview(imageView)
        view.addSubview(imageView)
        return imageView
    }

    private func getMovieTitle(movie: MovieDataModel) -> UILabel {
        let titleView = UILabel(frame: getFrame())
        titleView.text = movie.title
        titleView.backgroundColor = backgroundColor
        titleView.textColor = textColor
        titleView.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleView.lineBreakMode = .byWordWrapping
        titleView.numberOfLines = 2
        titleView.sizeToFit()
        //scrollView.addSubview(titleView)
        view.addSubview(titleView)
        return titleView
    }

    private func getMovieReleaseDate(movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        //TODO привести шакальскую дату в человечий вид
        labelView.text = "Дата релиза: " + movie.releaseDate
        labelView.backgroundColor = backgroundColor
        labelView.textColor = textColor
        labelView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        labelView.lineBreakMode = .byWordWrapping
        labelView.sizeToFit()
//        scrollView.addSubview(labelView)
        view.addSubview(labelView)
        return labelView
    }

    private func getTrailerTitle (movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        labelView.text = "Трейлер"
        labelView.backgroundColor = backgroundColor
        labelView.textColor = .cyan
        labelView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        labelView.sizeToFit()
//        scrollView.addSubview(labelView)
        view.addSubview(labelView)
        return labelView
    }

    private func getTrailerFrame (movie: MovieDataModel) -> UIView {
        let frameView = UIView(frame: getFrame())
        frameView.backgroundColor = .blue
//        scrollView.addSubview(frameView)
        view.addSubview(frameView)
        return frameView
    }

    private func getDescriptionTitle (movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        labelView.text = "О фильме"
        labelView.backgroundColor = backgroundColor
        labelView.textColor = textColor
        labelView.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        labelView.sizeToFit()
//        scrollView.addSubview(labelView)
        view.addSubview(labelView)
        return labelView
    }

    private func getDescription (movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        labelView.text = movie.overview
        labelView.backgroundColor = backgroundColor
        labelView.textColor = textColor
        labelView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        labelView.lineBreakMode = .byWordWrapping
        labelView.numberOfLines = 0
        labelView.sizeToFit()
//        scrollView.addSubview(labelView)
        view.addSubview(labelView)
        return labelView
    }

    func showMoviePictures (poster: UIImage?, backdrop: UIImage?) {
        guard let backdropImage = backdrop else {
            return
        }
        guard let posterImage = poster else {
            return
        }
        guard let movieData = self.movie else {
            return
        }

        let backdropImageView  = getBackdropImageView(image: backdropImage)
        let posterImageView = getPosterImageView(image: posterImage)
        let titleView = getMovieTitle(movie: movieData)
        let releaseView = getMovieReleaseDate(movie: movieData)
        let trailerTitleView = getTrailerTitle(movie: movieData)
        //let trailerFrame = getTrailerFrame(movie: movieData)
        let descriptionTitleView = getDescriptionTitle(movie: movieData)
        let descriptionView = getDescription(movie: movieData)

        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        releaseView.translatesAutoresizingMaskIntoConstraints = false
        trailerTitleView.translatesAutoresizingMaskIntoConstraints = false
        //trailerFrame.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitleView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //Backdrop image
            backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backdropImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backdropImageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant:  getImageOriginalSize(image: backdropImage).height),
            //Poster Image
            posterImageView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: viewShiftY ),
            posterImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            posterImageView.rightAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 50),
            posterImageView.bottomAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 100),
            //Movie title
            titleView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleView.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: viewShiftX),
            titleView.rightAnchor.constraint(equalTo: backdropImageView.rightAnchor),
            //Release date
            releaseView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -20),
            releaseView.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: viewShiftX),
            releaseView.rightAnchor.constraint(equalTo: backdropImageView.rightAnchor),
            //Trailer title
            trailerTitleView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: viewShiftY),
            trailerTitleView.leftAnchor.constraint(equalTo: view.leftAnchor),
            trailerTitleView.bottomAnchor.constraint(equalTo: trailerTitleView.topAnchor, constant: 30),

            //Trailer frame
//            trailerFrame.topAnchor.constraint(equalTo: trailerTitleView.bottomAnchor),
//            trailerFrame.leftAnchor.constraint(equalTo: view.leftAnchor),
//            trailerFrame.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 200),
//            trailerFrame.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100)
            //Overview Title
            descriptionTitleView.topAnchor.constraint(equalTo: trailerTitleView.bottomAnchor),
            descriptionTitleView.leftAnchor.constraint(equalTo: view.leftAnchor),
            //Overview
            descriptionView.topAnchor.constraint(equalTo: descriptionTitleView.bottomAnchor),
            descriptionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            descriptionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }

    private func getImageOriginalSize(image: UIImage) -> CGRect {
        let imageView = UIImageView(image: image)
        return imageView.frame
    }
}
