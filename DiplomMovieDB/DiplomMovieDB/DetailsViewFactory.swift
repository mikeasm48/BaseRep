//
//  DetailsFactory.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 11.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class DetailsViewFactory {
    let viewController: DetailsViewController
    private let backgroundColor = UIColor.black
    private let textColor = UIColor.white
    private let titleColor = UIColor.cyan
    private let defaultPosterImageName = "DefaultPoster"
    private let defaultBackdropImageName = "LogoMovieDB"
    
    private let viewShiftY: CGFloat = 30
    private let viewShiftX: CGFloat = 30

    init (viewController: DetailsViewController) {
        self.viewController = viewController
    }

    func buildDetailsView (poster: UIImage?, backdrop: UIImage?, savedState: Bool) {
        viewController.isDefaultPoster = false

        guard let view = viewController.view else {
            print("no view")
            return
        }
        
        guard let backdropImage = getPictureWithDefault(image: backdrop, defaultName: defaultBackdropImageName) else {
            return
        }
        guard let posterImage = getPictureWithDefault(image: poster, defaultName: defaultPosterImageName) else {
            return
        }
        //TODO не нужно
        guard let movieData = viewController.movie else {
            return
        }
        
        //Прихраниваем постер для детального отображения по клику на нем
        //TODO
        viewController.poster = posterImage
        
        let backdropImageView  = getBackdropImageView(image: backdropImage)
        viewController.scrollView = getScrollView()
        let scrollView = viewController.scrollView
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
        //TODO
//        didCheckCoreDataState(savedState)
        
//        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private func getPictureWithDefault(image: UIImage?, defaultName: String) -> UIImage? {
        guard let existImage = image else {
            if defaultPosterImageName == defaultName {
                viewController.isDefaultPoster = true
            }
            return UIImage(named: defaultName)
        }
        return existImage
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
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        return imageView
    }
    
    private func getPosterImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(frame: getFrame())
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
//        let posterTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (viewController.actionUITapGestureRecognizer))
//        imageView.isUserInteractionEnabled = true
//        imageView.addGestureRecognizer(posterTapGestureRecognizer)
        viewController.initGesture(imageView: imageView)
        return imageView
    }
    
    @objc func actionUITapGestureRecognizer () {

        print("gesture tap")
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
    
    private func getSaveButton (movie: MovieDataModel) -> UIButton {
        let buttonView: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Сохранить", for: .normal)
            button.backgroundColor = backgroundColor
            button.setTitleColor(.cyan, for: .normal)
            button.addTarget(self, action: #selector(viewController.tapButtonSave), for: .touchDown)
            button.frame = getFrame()
            return button
        }()
        return buttonView
    }
}
