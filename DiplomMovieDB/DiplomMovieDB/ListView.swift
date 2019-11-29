//
//  ViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ListView: UIViewController {
    let tableView = UITableView()
    let searchView = UIView()
    let searchInputField = UITextField()
    let reuseId = "UITableViewCellreuseId"
    //let interactor: InteractorInput
    let presenter: PresenterInputProtocol
    let detailViewController: DetailsView = DetailsView()

    var movies: [PresenterOutputDataType] = []

    init(presenter: PresenterInputProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Метод не реализован")
    }

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
        
        presenter.show()
    }
}

extension ListView: PresenterOutputProtocol, UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {

    func didLoadData(data: [PresenterOutputDataType]) {
        self.movies = data
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let model = movies[indexPath.row]
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.movie.overview
        return cell
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        presenter.search(by: text)
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO build details presenter and show details view
        //presenter.showMovieDetails(movie: movies[indexPath.row].movie)
        
//        detailViewController.setImage(image: model.image)
//        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
