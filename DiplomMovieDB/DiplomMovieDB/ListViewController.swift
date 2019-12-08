//
//  ViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol ListViewControllerProtocol: TableViewControllerProtocol {
}

class ListViewController: AbstractTableViewController, ListViewControllerProtocol {
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?

    var caption = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initAdditionalControlsWithLayoutConstraints() {
        setCaptionView()
        view.addSubview(caption)
        caption.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            caption.topAnchor.constraint(equalTo: view.topAnchor),
            caption.leftAnchor.constraint(equalTo: view.leftAnchor),
            caption.rightAnchor.constraint(equalTo: view.rightAnchor),
            caption.bottomAnchor.constraint(equalTo: caption.topAnchor, constant: 40),
            tableView.topAnchor.constraint(equalTo: caption.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    override func loadData() {
        interactor?.loadDataAsync()
    }

    override func fetchData() {
        loadData()
    }

    override func selectRow(indexPath: IndexPath) {
        router?.openDetails(movie: getDataHolder().getMovie(index: indexPath.row))
    }

    override func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        dataHolder?.setData(movies: movies, images: images)
        tableView.reloadData()
    }

    // MARK: - Private methods
    private func setCaptionView() {
        caption.backgroundColor = .white
        caption.textColor = .black
        caption.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        caption.text = "Последние поступления"
    }
}
