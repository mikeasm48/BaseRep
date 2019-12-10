//
//  ViewController.swift
//  DiplomMovieDB
//
//  Created by Михаил Асмаковец on 27.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

/// Протокол модуля со списком последних поступлений
protocol ListViewControllerProtocol: TableViewControllerProtocol {
}


/// Контроллер модуля списка последних поступлений
class ListViewController: AbstractTableViewController, ListViewControllerProtocol {
    var interactor: ListInteractorProtocol?
    var router: ListRouterProtocol?

    var caption = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /// Переопределено: точка расширения для добавления подзаголовка
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

    /// Переопределено: начальная загрузка данных
    override func loadData() {
        interactor?.loadDataAsync()
    }

    /// Переопределено: страничная подгрузка данных
    override func fetchData() {
        loadData()
    }

    /// Переопределено: выбор строки для загрузки модуля деталей
    ///
    /// - Parameter indexPath: строка в формате делегата таблицы
    override func selectRow(indexPath: IndexPath) {
        router?.openDetails(movie: getDataHolder().getMovie(index: indexPath.row))
    }

    /// Переопределено: получение данных от презентера
    ///- сохраняем в буфер для делегата таблицы
    ///-обновляем таблицы
    /// - Parameters:
    ///   - movies: фильмы
    ///   - images: изображения
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
