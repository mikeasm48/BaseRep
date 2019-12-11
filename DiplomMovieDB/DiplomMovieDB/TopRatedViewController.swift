//
//  TopRatedViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол модуля поплярных фильмов
protocol TopRatedViewControllerProtocol {
    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?])
}

/// Контроллер модуля поплярных фильмов
class TopRatedViewController: DataHolderViewController, TopRatedViewControllerProtocol {
    //Модуль
    var interactor: TopRatedInteractorProtocol?
    var router: TopRatedRouterProtocol?
    //Коллекция
    var collectionView: UICollectionView!
    let cellReuseId = "TopRatedCell"

    /// Элементы модуля
    override func viewDidLoad() {
        super.viewDidLoad()
        //Init collection
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView.init(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .darkGray
        collectionView.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseId)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        //Load data
        loadData()
    }

    /// Получает данные от презентера
    ///
    /// - Parameters:
    ///   - movies: фильмы
    ///   - images: изображения
    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        dataHolder?.setData(movies: movies, images: images)
        collectionView?.reloadData()
    }

    /// Вызов интерактора для начальной загрузки данных
    private func loadData() {
       interactor?.loadDataAsync()
    }
}

// MARK: - делегаты коллекции
extension TopRatedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getDataHolder().getCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId,
                                                            for: indexPath) as? TopRatedCollectionViewCell else {
            return TopRatedCollectionViewCell(frame: CGRect(x: 0, y: 0, width: view.frame.height, height: view.frame.height))
        }

        let model = getDataHolder().getMovie(index: indexPath.row)
        cell.picture.image = getDataHolder().getImage(path: model.backdropPath)
        //cell.picture
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model =  getDataHolder().getMovie(index: indexPath.row)
        let image = getDataHolder().getImage(path: model.backdropPath)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.openDetails(movie: getDataHolder().getMovie(index: indexPath.row))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
