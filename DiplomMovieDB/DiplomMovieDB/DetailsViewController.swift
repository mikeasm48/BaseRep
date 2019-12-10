//
//  MovieDetailViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол контроллера модуля просмотра деталей фильма
protocol DetailsViewControllerProtocol {
    func didShowDetails(poster: UIImage?, backdrop: UIImage?, savedState: Bool)
    func didCheckCoreDataState(_ saved: Bool)
}
/// Контроллер модуль просмотра деталей фильма
class DetailsViewController: UIViewController, DetailsViewControllerProtocol {

    var interactor: DetailsInteractorProtocol?
    var router: DetailsRouterProtocol?

    private var movie: MovieDataModel?
    private var poster: UIImage?
    private var zoomedPosterView: UIView?
    private var movieSaveState = false
    private var isDefaultPoster = false

    private let backgroundColor = UIColor.black
    private let textColor = UIColor.white
    private let titleColor = UIColor.cyan
    private let defaultPosterImageName = "DefaultPoster"
    private let defaultBackdropImageName = "LogoMovieDB"

    private let viewShiftY: CGFloat = 30
    private let viewShiftX: CGFloat = 30

    var scrollView = UIScrollView()

    var lastFrame: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        showDetails()
    }

    /// Вызов интерактора  для загрузки данных модуля
    func showDetails() {
        guard let movieData = DataHolder.getMovie() else {
            return
        }
        self.movie = movieData
        interactor?.loadDetails(movie: movieData)
    }

    /// Полуяение данных модуля и отображение элементов интерфейса
    ///
    /// - Parameters:
    ///   - poster: изображение постера в формате контроллера
    ///   - backdrop: изображение заставки в формате контроллера
    ///   - savedState: сохзраненн ли фильм в изранном
    func didShowDetails (poster: UIImage?, backdrop: UIImage?, savedState: Bool) {
        isDefaultPoster = false
        guard let backdropImage = getPictureWithDefault(image: backdrop, defaultName: defaultBackdropImageName) else {
            return
        }
        guard let posterImage = getPictureWithDefault(image: poster, defaultName: defaultPosterImageName) else {
            return
        }
        guard let movieData = self.movie else {
            return
        }

        //Прихраниваем постер для детального отображения по клику на нем
        self.poster = posterImage

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
        didCheckCoreDataState(savedState)
    }

    // MARK: - Private methods
    private func getScrollView () -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
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
        let posterTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (self.actionUITapGestureRecognizer))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(posterTapGestureRecognizer)
        return imageView
    }

    @objc func actionUITapGestureRecognizer () {
        zoomPosterImage()
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
        labelView.text = "Дата релиза: " + convertLocalDateString(from: movie.releaseDate)
        labelView.backgroundColor = backgroundColor
        labelView.textColor = titleColor
        labelView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        labelView.lineBreakMode = .byWordWrapping
        labelView.sizeToFit()
        return labelView
    }

    private func convertLocalDateString(from movieDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateToConvert = dateFormatter.date(from: movieDate)
        guard let date = dateToConvert else {
            return ""
        }
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateResult = dateFormatter.string(from: date)
        return dateResult + " г."
    }

    private func getSaveButton (movie: MovieDataModel) -> UIButton {
        let buttonView: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Сохранить", for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(.cyan, for: .normal)
            button.addTarget(self, action: #selector(tapButtonSave), for: .touchDown)
            button.frame = getFrame()
            return button
        }()
        return buttonView
    }

    @objc func tapButtonSave () {
        guard let movieData = movie else {
            return
        }
        if movieSaveState {
            interactor?.deleteSavedMovie(movie: movieData)
        } else {
            interactor?.saveMovie(movie: movieData)
        }
        self.navigationController?.popViewController(animated: true)
    }

    func zoomPosterImage() {
        if isDefaultPoster {
            return
        }
        let zoomedView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: view.frame.height))
        let imageView = UIImageView(image: self.poster)
        imageView.frame = zoomedView.frame
        imageView.contentMode = .scaleAspectFit
        let zoomedPosterTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closePosterZoomImage))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(zoomedPosterTapGestureRecognizer)
        zoomedView.addSubview(imageView)
        view.addSubview(zoomedView)
        self.zoomedPosterView = zoomedView
    }

    @objc func closePosterZoomImage() {
        zoomedPosterView?.layer.add(getZoomOutAnimation(), forKey: "out")
    }

    private func getZoomOutAnimation() -> CABasicAnimation {
        let animationBasicOpacity = CABasicAnimation(keyPath: "opacity")
        animationBasicOpacity.fromValue = 1.0
        animationBasicOpacity.toValue = 0.0
        animationBasicOpacity.duration = 0.5
        animationBasicOpacity.autoreverses = false
        animationBasicOpacity.repeatCount = 1
        animationBasicOpacity.delegate = self
        return animationBasicOpacity
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

    private func getPictureWithDefault(image: UIImage?, defaultName: String) -> UIImage? {
        guard let existImage = image else {
            if defaultPosterImageName == defaultName {
                isDefaultPoster = true
            }
            return UIImage(named: defaultName)
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

    override func viewDidLayoutSubviews() {
        scrollView.updateContentView()
    }
}

// MARK: - расширения ScrollView
extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY })
            .last?.frame.maxY ?? contentSize.height
    }
}

// MARK: - расширение для анимации
extension DetailsViewController: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        zoomedPosterView?.removeFromSuperview()
    }
}
