//
//  MovieDetailViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol DetailsViewControllerProtocol {
    func didShowDetails(poster: UIImage?, backdrop: UIImage?)
    func didCheckCoreDataState(_ saved: Bool)
}

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {

    var interactor: DetailsInteractorProtocol?
    var router: DetailsRouterProtocol?

    private var movie: MovieDataModel?
    private var movieSaveState = false

    private let backgroundColor = UIColor.black
    private let textColor = UIColor.white
    private let titleColor = UIColor.cyan

    private let viewShiftY: CGFloat = 30
    private let viewShiftX: CGFloat = 30

    var scrollView = UIScrollView()

    var lastFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        showDetails()
    }

    func showDetails() {
        guard let movieData = DataHolder.getMovie() else {
            return
        }
        self.movie = movieData
        interactor?.loadPictures(posterPath: movieData.posterPath, backdropPath: movieData.backdropPath)
    }

    private func getScrollView () -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        return scrollView
    }

    private func getFrame() -> CGRect {
        return CGRect( x: 0, y: 0, width: 0, height: 0)
    }

    private func getBackdropImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: getFrame())
        imageView.contentMode = .center
        imageView.image = image
        return imageView
    }

    private func getPosterImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: getFrame())
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
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
        return titleView
    }

    private func getMovieReleaseDate(movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        //TODO привести шакальскую дату в человечий вид
        labelView.text = "Дата релиза: " + movie.releaseDate
        labelView.backgroundColor = backgroundColor
        labelView.textColor = titleColor
        labelView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        labelView.lineBreakMode = .byWordWrapping
        labelView.sizeToFit()
        return labelView
    }

    private func getSaveButton (movie: MovieDataModel) -> UIButton {
        let buttonView: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Сохранить", for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(.cyan, for: .normal)
            button.addTarget(self, action:  #selector(tapButtonSave), for:.touchDown)
            button.frame = getFrame()
            return button
        }()
        return buttonView
    }

    //Пошли в CoreData
    @objc func tapButtonSave () {
        guard let movieData = movie else {
            return
        }
        if movieSaveState {
            interactor?.deleteSavedMovie(movie: movieData)
        } else {
            interactor?.saveMovie(movie: movieData)
        }
    }

    private func getDescriptionTitle (movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        labelView.text = "О фильме"
        labelView.backgroundColor = backgroundColor
        labelView.textColor = titleColor
        labelView.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        labelView.sizeToFit()
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
        return labelView
    }

    private func getPictureWithDefault(image: UIImage?) -> UIImage? {
        guard let existImage = image else {
            return UIImage(named: "LogoMovieDB")
        }
        return existImage
    }

    func didCheckCoreDataState(_ saved: Bool) {
        self.movieSaveState = saved
        setSaveButtonState(saved: saved)
    }

    private func setSaveButtonState(saved: Bool) {
        for subview in scrollView.subviews {
            guard let button  = subview as? UIButton else {
                continue
            }
            if saved {
                button.setTitle("Удалить сохраненный", for: .normal)
            } else {
                button.setTitle("Сохранить", for: .normal)
            }
        }
    }

    func didShowDetails (poster: UIImage?, backdrop: UIImage?) {
        guard let backdropImage = getPictureWithDefault(image: backdrop) else {
            return
        }
        guard let posterImage = getPictureWithDefault(image: poster) else {
            return
        }
        guard let movieData = self.movie else {
            return
        }

        let backdropImageView  = getBackdropImageView(image: backdropImage)
         scrollView = getScrollView()
        let posterImageView = getPosterImageView(image: posterImage)
        let titleView = getMovieTitle(movie: movieData)
        let releaseView = getMovieReleaseDate(movie: movieData)
        let saveButtonView = getSaveButton(movie: movieData)
        let descriptionTitleView = getDescriptionTitle(movie: movieData)
        let descriptionView = getDescription(movie: movieData)

        view.addSubview(scrollView)
        view.addSubview(backdropImageView)
        scrollView.addSubview(posterImageView)
        scrollView.addSubview(titleView)
        scrollView.addSubview(releaseView)
        scrollView.addSubview(descriptionTitleView)
        scrollView.addSubview(descriptionView)
        scrollView.addSubview(saveButtonView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        releaseView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTitleView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        saveButtonView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            //Backdrop image
            backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backdropImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            //Scroll view
            scrollView.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: viewShiftY),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //Poster Image
            posterImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            posterImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: viewShiftX),
            posterImageView.rightAnchor.constraint(equalTo: posterImageView.leftAnchor, constant: 100),
            posterImageView.bottomAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 200),
            //Movie title
            titleView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleView.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: viewShiftX),
            titleView.rightAnchor.constraint(equalTo: backdropImageView.rightAnchor),
            //Release date
            releaseView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            releaseView.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: viewShiftX),
            releaseView.rightAnchor.constraint(equalTo: backdropImageView.rightAnchor),
            //Overview Title
            descriptionTitleView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: viewShiftY),
            descriptionTitleView.leftAnchor.constraint(equalTo: view.leftAnchor),
            //Overview
            descriptionView.topAnchor.constraint(equalTo: descriptionTitleView.bottomAnchor),
            descriptionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            descriptionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            //Save button
            saveButtonView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: viewShiftY),
            saveButtonView.leftAnchor.constraint(equalTo: view.leftAnchor),
            saveButtonView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        checkSaveState()
    }

    private func checkSaveState() {
        guard let movieData = movie else {
            return
        }
        interactor?.checkMovieSaved(movie: movieData)
    }

    override func viewDidLayoutSubviews() {
        scrollView.updateContentView()
    }
}

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY })
            .last?.frame.maxY ?? contentSize.height
    }
}
