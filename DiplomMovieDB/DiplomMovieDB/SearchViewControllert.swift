//
//  SearchViewControllert.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

protocol SearchViewControllerProtocol {
}

class SearchViewController: AbstractTableViewController, SearchViewControllerProtocol {
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?

    let searchInputField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .darkGray
        navigationItem.title = "Поиск"
    }
    
    override func initAdditionalControlsWithLayoutConstraints() {
        view.addSubview(searchInputField)
        searchInputField.delegate = self
        searchInputField.backgroundColor = .white
        searchInputField.borderStyle = .roundedRect

        searchInputField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchInputField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchInputField.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchInputField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchInputField.bottomAnchor.constraint(equalTo: searchInputField.topAnchor, constant: 30),
            //Table
            tableView.topAnchor.constraint(equalTo: searchInputField.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let _ = textField.text else {
            return false
        }
        //TODO
        //presenter.search(by: text)
        return true
    }
}
