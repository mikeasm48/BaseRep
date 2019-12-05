//
//  TopRatedViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol TopRatedViewControllerProtocol {
    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?])
}

class TopRatedViewController: MovieListViewController, TopRatedViewControllerProtocol {
    //Module
    var interactor: TopRatedInteractorProtocol?
    var router: TopRatedRouterProtocol?
    //Collection
    var collectionView: UICollectionView!
    let cellHeight: CGFloat = 90.0
    let cellSpacing: CGFloat = 10.0
    let cellSectionSpacing: CGFloat = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        //Init collection
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView.init(frame: view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        collectionView.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: "topRatedCell")
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

    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        dataHolder?.setData(movies: movies, images: images)
        collectionView?.reloadData()
    }

    private func loadData() {
       interactor?.loadDataAsync()
    }
}

extension TopRatedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getDataHolder().getCount()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCell",
                                                            for: indexPath) as? TopRatedCollectionViewCell else {
            return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        }
        let model = getDataHolder().getMovie(index: indexPath.row)
        cell.picture.image = getDataHolder().getImage(path: model.backdropPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = cellHeight
        return CGSize(width: cellSize, height: cellSize)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return cellSpacing
//    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.openDetailsModule()
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: cellSectionSpacing, left: cellSectionSpacing, bottom: cellSectionSpacing, right: cellSectionSpacing)
//    }
}
