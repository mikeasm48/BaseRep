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
        return MovieModel.shared.moviesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let movies = MovieModel.shared.getMovies()
        let model = movies[indexPath.row]
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.movie.originalTitle
        return cell
    }

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        guard let _ = textField.text else {
//            return false
//        }
//        //TODO
//        //presenter.search(by: text)
//        return true
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       router?.openDetailsModule()
    }
}
