//
//  ViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol ListViewControllerProtocol: AnyObject {
}

class ListViewController: UIViewController, ListViewControllerProtocol {
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?
    var recordsCount = 0
    //View
    let tableView = UITableView()
    //let searchView = UIView()
    //let searchInputField = UITextField()
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

        interactor?.loadDataAsync()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recordsCount = DataModel.shared.getListCount(list: ListType.lastRecent)
        return recordsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)

        let model = DataModel.shared
        let movie = model.getMovie(list: ListType.lastRecent, index: indexPath.row)
        cell.imageView?.image = ImageFactory().getImage(for: movie.backdropPath)
        cell.textLabel?.text = movie.title
        if model.needListFetch(list: ListType.lastRecent, currentRecord: indexPath.row) {
            interactor?.loadDataAsync()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       router?.openDetailsModule()
    }
}
