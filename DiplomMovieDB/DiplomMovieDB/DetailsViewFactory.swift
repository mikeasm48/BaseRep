//
//  DetailsFactory.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 11.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
//Протокол фабрики деталей представления фильма
protocol DetailsViewFactoryProtocol {

    /// Сборка представления
    ///
    /// - Parameters:
    ///   - movieData: даные фильма
    ///   - poster: изображение постера
    ///   - backdrop: изображение заставки
    ///   - savedState: статус сохранения в CoreData
    /// - Returns: ничего
    func buildDetailsView (movieData: MovieDataModel,
                           poster: UIImage?,
                           backdrop: UIImage?,
                           savedState: Bool)

    /// Возваращет изображение постера для масштабирования
    ///
    /// - Returns: изображение постера
    func getPosterForZoom() -> UIImage?

    /// Изображает контрол постера для обработки нажатия
    ///
    /// - Returns: контрол постера
    func getPosterViewForZoom() -> UIImageView

    /// Возвращает скроллируемую часть представления
    ///
    /// - Returns: скролируемая часть представления
    func getScrollView() -> UIScrollView

    /// Возвращает кнопку сохранения в  CoreData
    ///
    /// - Returns: кнопка сохранения
    func getSaveButton() -> UIButton
}
//Фабрика деталей представления фильма
class DetailsViewFactory: DetailsViewFactoryProtocol {
    let viewController: DetailsViewControllerProtocol
    private let backgroundColor = UIColor.black
    private let textColor = UIColor.white
    private let titleColor = UIColor.cyan
    private let defaultPosterImageName = "DefaultPoster"
    private let defaultBackdropImageName = "LogoMovieDB"

    private let viewShiftY: CGFloat = 30
    private let viewShiftX: CGFloat = 30

    //Постер для zoom
    private var posterForZoom: UIImage?
    private var posterImageView = UIImageView()
    //Кнопка соханения
    private var saveButtonView = UIButton()
    //scrollView
    var scrollView = UIScrollView()
    //Лого: на основании этого признака выбираем способ масшатбирования изображения backdrop
    private var isDefaultBackdrop = false

    init (viewController: DetailsViewControllerProtocol) {
        self.viewController = viewController
    }

    /// Сборка преджставления
    ///
    /// - Parameters:
    ///   - movieData: фильм
    ///   - poster: постер
    ///   - backdrop: заставка
    ///   - savedState: статус сохранения
    func buildDetailsView (movieData: MovieDataModel, poster: UIImage?, backdrop: UIImage?, savedState: Bool) {
        isDefaultBackdrop = false
        self.posterForZoom = poster

        guard let view = viewController.getView() else {
            return
        }

        guard let backdropImage = getPictureWithDefault(image: backdrop, defaultName: defaultBackdropImageName) else {
            return
        }
        guard let posterImage = getPictureWithDefault(image: poster, defaultName: defaultPosterImageName) else {
            return
        }

        let backdropImageView  = buildBackdropImageView(image: backdropImage)
        scrollView = buildScrollView()
        self.posterImageView = buildPosterImageView(image: posterImage)
        let titleView = buildMovieTitle(movie: movieData)
        let releaseView = buildMovieReleaseDate(movie: movieData)
        saveButtonView = buildSaveButton(movie: movieData)
        let descriptionTitleView = buildDescriptionTitle(movie: movieData)
        let descriptionView = buildDescription(movie: movieData)

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
            backdropImageView.bottomAnchor.constraint(equalTo: backdropImageView.topAnchor, constant: view.frame.height/4),
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
    }

    /// Возвращает изображение постера
    ///
    /// - Returns: Изображение постера
    func getPosterForZoom() -> UIImage? {
        return self.posterForZoom
    }

    /// Вовзращает контрол постера
    ///
    /// - Returns: контрол
    func getPosterViewForZoom() -> UIImageView {
        return self.posterImageView
    }

    /// Вовзращает скроллируемую часть представления
    ///
    /// - Returns: скролируемая часть
    func getScrollView() -> UIScrollView {
        return scrollView
    }

    /// Возвращает кнопку сохранения
    ///
    /// - Returns: кнопка сохранения
    func getSaveButton() -> UIButton {
        return saveButtonView
    }

    // MARK: - детали реализацции

    private func getPictureWithDefault(image: UIImage?, defaultName: String) -> UIImage? {
        guard let existImage = image else {
            if defaultName == defaultBackdropImageName {
                isDefaultBackdrop = true
            }
            return UIImage(named: defaultName)
        }
        return existImage
    }

    private func buildDescriptionTitle (movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        labelView.text = "О фильме"
        labelView.backgroundColor = backgroundColor
        labelView.textColor = titleColor
        labelView.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        labelView.sizeToFit()
        return labelView
    }

    private func buildDescription (movie: MovieDataModel) -> UILabel {
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

    private func buildScrollView () -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = false
        return scrollView
    }

    private func getFrame() -> CGRect {
        return CGRect( x: 0, y: 0, width: 0, height: 0)
    }

    private func buildBackdropImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: getFrame())
        if isDefaultBackdrop {
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView.contentMode = .scaleAspectFill
        }
        imageView.image = image
        return imageView
    }

    private func buildPosterImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: getFrame())
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        return imageView
    }

    private func buildMovieTitle(movie: MovieDataModel) -> UILabel {
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

    private func buildMovieReleaseDate(movie: MovieDataModel) -> UILabel {
        let labelView = UILabel(frame: getFrame())
        labelView.text = "Дата релиза: " + convertLocalDateString(from: movie.releaseDate)
        labelView.backgroundColor = backgroundColor
        labelView.textColor = titleColor
        labelView.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        labelView.lineBreakMode = .byWordWrapping
        labelView.numberOfLines = 2
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

    private func buildSaveButton (movie: MovieDataModel) -> UIButton {
        let buttonView: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Сохранить", for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(.cyan, for: .normal)
            button.frame = getFrame()
            return button
        }()
        return buttonView
    }
}
