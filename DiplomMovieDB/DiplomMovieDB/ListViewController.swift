//
//  ViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol ListViewControllerProtocol {
    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?])
}

class ListViewController: MovieListViewController, ListViewControllerProtocol {
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?
    var recordsCount = 0
    //View
    let tableView = UITableView()
    let reuseId = "UITableViewCellreuseId"

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .darkGray
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        //Load data
        loadData()
    }

    private func loadData() {
        interactor?.loadDataAsync()
    }

    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        dataHolder?.setData(movies: movies, images: images)
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDataHolder().getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let movie = getDataHolder().getMovie(index: indexPath.row)
        cell.imageView?.image = getDataHolder().getImage(path: movie.backdropPath)
        cell.textLabel?.text =  movie.title
        if getDataHolder().needFetch(currentIndex: indexPath.row) {
            loadData()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       router?.openDetailsModule()
    }
}
