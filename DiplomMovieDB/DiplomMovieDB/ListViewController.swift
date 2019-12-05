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
        view.addSubview(tableView)
        tableView.backgroundColor = .darkGray
        let caption = getCaptionView()
        caption.text = "Последние поступления"
        view.addSubview(caption)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            caption.topAnchor.constraint(equalTo: view.topAnchor),
            caption.leftAnchor.constraint(equalTo: view.leftAnchor),
            caption.rightAnchor.constraint(equalTo: view.rightAnchor),
            caption.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            tableView.topAnchor.constraint(equalTo: caption.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        //Load data
        loadData()
    }

    private func getCaptionView() -> UITextView {
        let caption = UITextView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        caption.backgroundColor = .white
        caption.textColor = .black
        caption.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return caption
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
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: reuseId)

        let movie = getDataHolder().getMovie(index: indexPath.row)
        cell.backgroundColor = .white
        cell.imageView?.image = getDataHolder().getImage(path: movie.backdropPath)
        cell.textLabel?.text =  movie.title
        cell.textLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = movie.overview
        cell.detailTextLabel?.numberOfLines = 3
        if getDataHolder().needFetch(currentIndex: indexPath.row) {
            loadData()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       router?.openDetailsModule()
    }
}
