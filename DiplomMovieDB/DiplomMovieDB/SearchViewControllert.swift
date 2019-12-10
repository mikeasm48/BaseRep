//
//  SearchViewControllert.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 03.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
/// Протокол контроллера модуля поиска фильмов
protocol SearchViewControllerProtocol: TableViewControllerProtocol {
}
/// Контроллер модуля поиска фильмов
class SearchViewController: AbstractTableViewController, SearchViewControllerProtocol {
    var interactor: SearchInteractorProtocol?
    var router: SearchRouterProtocol?

    let searchInputField = UITextField()
    //Для задержки поиска
    lazy var searchQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "search_queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Поиск"
        view.backgroundColor = .darkGray
        tableView.backgroundColor = .white
    }

    /// Преопределяем метод для инициализации строки поиска с таблицей
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

    /// Получение данных из презентера
    ///
    /// - Parameters:
    ///   - movies: фильмы
    ///   - images: изображения
    override func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
        dataHolder?.setData(movies: movies, images: images)
        tableView.reloadData()
    }

    /// Открываем детали фильма
    ///
    /// - Parameter indexPath: индекс строки в формате делагата таблицы
    override func selectRow(indexPath: IndexPath) {
        router?.openDetails(movie: getDataHolder().getMovie(index: indexPath.row))
    }
}

// MARK: - делегат строки поиска
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textToSearch = textField.text else {
            return false
        }
        if textToSearch.isEmpty {
            return false
        }
        executeSearchWithDelay(searchText: textToSearch)
        return true
    }

    /// Вызываем поиск с задержкой 2 секунды
    ///
    /// - Parameter searchText: маска поиска
    private func executeSearchWithDelay(searchText: String) {
        searchQueue.cancelAllOperations()
        let operation = DelayOperation(delay: 2) {_ in
            print("Searching: " + searchText)
            self.dataHolder?.resetData()
            self.tableView.reloadData()
            self.interactor?.search(text: searchText)
        }
        searchQueue.addOperation(operation)
    }
}
