//
//  ViewController.swift
//  HWImageFilter
//
//  Created by Михаил Асмаковец on 25.11.2019.
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
    let imageViewController: ImageViewController = ImageViewController()

    init(interactor: InteractorInput) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Метод не реализован")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Навигация
        navigationItem.title = "Список"
        //
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
        search(by: defaultSearchText)
    }

    private func search(by searchString: String) {
        clearImages(with: false)
        interactor.loadImageList(by: searchString) { [weak self] models in
            self?.loadImages(with: models, tag: searchString)
        }
    }

    private func clearImages(with refresh: Bool) {
        self.images.removeAll()
        if refresh {
            self.tableView.reloadData()
        }
    }

    private func loadImages(with models: [ImageModel], tag: String) {
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
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        let model = images[indexPath.row]
        cell.imageView?.image = model.image
        cell.textLabel?.text = model.description
        return cell
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        self.search(by: text)
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = images[indexPath.row]
        imageViewController.setImage(image: model.image)
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}
