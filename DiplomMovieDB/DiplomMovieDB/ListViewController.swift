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
    let searchView = UIView()
    let searchInputField = UITextField()
    let reuseId = "UITableViewCellreuseId"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        navigationItem.title = "Список фильмов"

        view.addSubview(tableView)
        view.addSubview(searchView)
        searchView.backgroundColor = .darkGray
        searchView.addSubview(searchInputField)
        searchInputField.delegate = self
        searchInputField.backgroundColor = .white
        searchInputField.borderStyle = .roundedRect

        searchInputField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchInputField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 20),
            searchInputField.leftAnchor.constraint(equalTo: searchView.leftAnchor),
            searchInputField.rightAnchor.constraint(equalTo: searchView.rightAnchor),
            searchInputField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -20),

            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: tableView.topAnchor),

            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self

        interactor?.loadDataAsync()
    }
}

extension ListViewController: UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {

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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        //TODO
        //presenter.search(by: text)
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       router?.openDetailsModule()
    }
}
