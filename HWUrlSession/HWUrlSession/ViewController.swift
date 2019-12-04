//
//  ViewController.swift
//  HWUrlSession
//
//  Created by Михаил Асмаковец on 15.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let defaultSearchText = "Cat"
    let tableView = UITableView()
    let searchView = UIView()
    let searchInputField = UITextField()
    var images: [ImageViewModel] = []
    let reuseId = "UITableViewCellreuseId"
    let interactor: InteractorInput
    //Нужно для подгрузки картинок частями
    var models: [ImageModel] = []
    //Количество загружаемых за один fetch картинок
    let fetchModelsCount = 20

    lazy var loadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "load image queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    init(interactor: InteractorInput) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Метод не реализован")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(searchView)
        searchView.backgroundColor = .darkGray
        searchView.addSubview(searchInputField)
        searchInputField.delegate = self
        searchInputField.backgroundColor = .white
        searchInputField.text = defaultSearchText
        searchInputField.borderStyle = .roundedRect

        searchInputField.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchInputField.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 50),
            searchInputField.leftAnchor.constraint(equalTo: searchView.leftAnchor),
            searchInputField.rightAnchor.constraint(equalTo: searchView.rightAnchor),
            searchInputField.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -20),

            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: tableView.topAnchor),

            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        search(by: defaultSearchText, delay: 0)
    }

    private func search(by searchString: String, delay: Int) {
        loadQueue.cancelAllOperations()
        //Вариант 1
        loadQueue.addOperation {
            sleep(UInt32(delay))
            self.doSearch(by: searchString)
        }
        //Вариант 2
//        let operation = LoadOperation(viewCntroller: self, text: searchString)
//        loadQueue.addOperation(operation)
    }

    func doSearch(by searchString: String) {
        print("doSearch start: \(searchString)")
        self.images.removeAll()
        self.interactor.loadImageList(by: searchString) { [weak self] models in
            self?.models = models
            self?.loadImages()
        }
    }

    func loadImages() {
        let models = self.models.prefix(fetchModelsCount)
        let group = DispatchGroup()
        for model in models {
            group.enter()
            interactor.loadImage(at: model.path) { [weak self] image in
                guard let image = image else {
                    group.leave()
                    return
                }
                let viewModel = ImageViewModel(description: model.description,
                                               image: image)
                self?.images.append(viewModel)
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            self.fetchModels()
            self.tableView.reloadData()
        }
    }

    private func fetchModels() {
        if fetchModelsCount > models.count {
            models.removeAll()
        } else {
            models.removeFirst(fetchModelsCount)
        }
    }
}

extension ViewController: UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let model = images[indexPath.row]
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.description
        fetchImages(at: indexPath.row)
        return cell
    }

    private func fetchImages(at row: Int) {
        if (row == images.count - 1) &&  (models.count) > 0 {
            loadImages()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        self.search(by: text, delay: 4)
        return true
    }
}
