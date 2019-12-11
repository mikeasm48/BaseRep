//
//  TableViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 07.12.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол табличного контроллера
protocol TableViewControllerProtocol {

    /// Загрузка данных, вызывает интерактор
    func loadData()

    /// Возврат данных, вызывается из презентера
    ///
    /// - Parameters:
    ///   - movies: данные фильмов
    ///   - images: данные изображений в формате контроллера
    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?])

    /// Событие выбора строки таблицы/элемента коллекции контролера
    ///служит для начала вызова другого модуля (деталей)
    /// - Parameter indexPath:  инфорамация о выбранной строке в формате делегата таблицы
    func selectRow(indexPath: IndexPath)
    /// Перепределяется для страничной подгрузки данных
    func fetchData()
}

/// Абстрактный предок табличный контроллеров
class AbstractTableViewController: DataHolderViewController, TableViewControllerProtocol {
    let tableView = UITableView()

    let reuseId = "UITableViewCellreuseId"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.backgroundColor = .darkGray
        initAdditionalControlsWithLayoutConstraints()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //Load data
        loadData()
    }

    /// Метод может быть переопределен в наследниках для добавления дополнительных элементов
    /// установкой для них новых layout constraints относительно tableView
    func initAdditionalControlsWithLayoutConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    // MARK: - TableViewControllerProtocol Stubs

    /// Заглушка: загрузка данных
    func loadData() {
    }

    /// Заглушка: подгрузка новой страницы
    func fetchData() {
    }

    /// Заглушка: возврат данныз от презентера
    func didLoadData(movies: [MovieDataModel], images: [String: UIImage?]) {
    }

    /// Заглущка: выбор строки
    func selectRow(indexPath: IndexPath) {
    }
}

// MARK: - расширение для делегатов
extension AbstractTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getDataHolder().getCount()
    }

    /// Рисуем строку таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: reuseId)
        let movie = getDataHolder().getMovie(index: indexPath.row)
        cell.backgroundColor = .white
        cell.imageView?.image = getDataHolder().getImage(path: movie.posterPath)
        cell.textLabel?.text =  movie.title
        cell.textLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = movie.overview
        cell.detailTextLabel?.numberOfLines = 3
        if getDataHolder().needFetch(currentIndex: indexPath.row) {
            fetchData()
        }
        return cell
    }

    /// Высота строки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    /// Выбор строки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(indexPath: indexPath)
    }
}
