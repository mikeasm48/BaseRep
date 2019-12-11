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

    /// Интерфейс для установки статуса сохранения фильма
    ///
    /// - Parameter saved: статус сохранения фильма
    func didCheckCoreDataState(_ saved: Bool)

    /// Интерфейс для установки изображения постера для увеличения
    ///
    /// - Parameters:
    ///   - poster: изображение постера
    ///   - tapView: контрол для обработки нажатия
    func setPosterForZoom(poster: UIImage?, tapView: UIImageView)

    /// Интерфейс установки области прокрутки контента
    ///
    /// - Parameter scrollView: с установки области прокрутки
    func setScrollView(scrollView: UIScrollView)

    /// Возвращает view
    func getView() -> UIView?
    
    /// Инициализирует обработчик кнопки сохранения
    func initSaveButton()
}

/// Контроллер модуль просмотра деталей фильма
class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    var interactor: DetailsInteractorProtocol?
    var router: DetailsRouterProtocol?

    var movie: MovieDataModel?

    private var zoomedPosterView: UIView?
    private var movieSaveState = false
    //Poster для zoom
    var poster: UIImage?

    private let backgroundColor = UIColor.black

    var scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        showDetails()
    }

    /// Вызов интерактора  для загрузки данных модуля при загрузке
    func showDetails() {
        guard let movieData = DataHolder.getMovie() else {
            return
        }
        self.movie = movieData
        interactor?.loadDetails(movie: movieData)
    }

    /// Устанавливает состояние соответствующее статусу фильма
    ///
    /// - Parameter saved: статус сохранения фильма в  CoreData
    func didCheckCoreDataState(_ saved: Bool) {
        self.movieSaveState = saved
        setSaveButtonState(saved: saved)
    }
    /// Устанавливает картинку постера для увеличения
    ///
    /// - Parameters:
    ///   - poster: изоражения для увеличения
    ///   - tapView: контрол для клика
    func setPosterForZoom(poster: UIImage?, tapView: UIImageView){
        self.poster = poster
        initGesture(imageView: tapView)
    }

    /// Устанавливает область прокрутки контента
    ///
    /// - Parameter scrollView: область прокрутки контена
    func setScrollView(scrollView: UIScrollView){
        self.scrollView = scrollView
    }
    
    func getView() -> UIView? {
        return self.view
    }
    
    func initSaveButton() {
        guard let button = getSaveButton() else {
            return
        }
        button.addTarget(self, action: #selector(self.tapButtonSave), for: .touchDown)
    }

    // MARK: - детали реализации

    private func initGesture(imageView: UIImageView){
        let posterTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector (self.actionUITapGestureRecognizer))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(posterTapGestureRecognizer)
    }

    /// Нажате для увеличение изображения
    @objc func actionUITapGestureRecognizer () {
        zoomPosterImage()
    }

    /// Нажатие кнопки сохранения
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
        if self.poster == nil {
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

    private func getSaveButton() -> UIButton? {
        for subview in scrollView.subviews {
            guard let button  = subview as? UIButton else {
                continue
            }
            return button
        }
        return nil
    }

    private func setSaveButtonState(saved: Bool) {
//        for subview in scrollView.subviews {
//            guard let button  = subview as? UIButton else {
//                continue
//            }
//            if saved {
//                button.setTitle("Удалить сохраненный", for: .normal)
//            } else {
//                button.setTitle("Сохранить", for: .normal)
//            }
//        }
        guard let button = getSaveButton() else {
            return
        }
        if saved {
            button.setTitle("Удалить сохраненный", for: .normal)
        } else {
            button.setTitle("Сохранить", for: .normal)
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
