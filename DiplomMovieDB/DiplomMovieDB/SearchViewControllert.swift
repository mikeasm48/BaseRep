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

class SearchViewController: UIViewController, SearchViewControllerProtocol {
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?

    let searchInputField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(searchInputField)
        searchInputField.backgroundColor = .white

        searchInputField.delegate = self
        searchInputField.backgroundColor = .white
        searchInputField.borderStyle = .roundedRect
        searchInputField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchInputField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            searchInputField.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchInputField.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchInputField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)])
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
