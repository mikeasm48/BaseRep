//
//  Interactor.swift
//  HWCoreData
//
//  Created by Михаил Асмаковец on 20.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
import CoreData

protocol InteractorInput {
    func loadImage(at path: String, completion: @escaping (UIImage?) -> Void)
    func loadImageList(by searchString: String, completion: @escaping ([ImageModel]) -> Void)
    func storeImageList(at path: String, images: [ImageViewModel])
    func readImageListFromStore(by searchString: String) -> [ImageViewModel]
    func clearStoredImages()
}

class Interactor: InteractorInput {
    let networkService: NetworkServiceInput

    init(networkService: NetworkServiceInput) {
        self.networkService = networkService
    }

    func loadImage(at path: String, completion: @escaping (UIImage?) -> Void) {
        networkService.getData(at: path, parameters: nil) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
    }

    func loadImageList(by searchString: String, completion: @escaping ([ImageModel]) -> Void) {
        let url = API.searchPath(text: searchString, extras: "url_m")
        networkService.getData(at: url) { data in
            guard let data = data else {
                completion([])
                return
            }
            let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: .init()) as? [String: Any]

            guard let response = responseDictionary,
                let photosDictionary = response["photos"] as? [String: Any],
                let photosArray = photosDictionary["photo"] as? [[String: Any]] else {
                    completion([])
                    return
            }

            let models = photosArray.map { (object) -> ImageModel in
                let urlString = object["url_m"] as? String ?? ""
                let    title = object["title"] as? String ?? ""
                return ImageModel(path: urlString, description: title)
            }
            completion(models)
        }
    }
    //Сохраняем данные в CoreData
    func storeImageList(at path: String, images: [ImageViewModel]) {
        CoreDataStack.shared.persistentContainer.performBackgroundTask { (context) in
            for imageViewModel in images {
                let dataObject = MOImage(context: context)
                dataObject.searchTag = path
                dataObject.imageDescription = imageViewModel.description
                dataObject.imageData = imageViewModel.image.jpegData(compressionQuality: 1.0)! as NSData
                do {
                    try context.save()
                } catch {
                    fatalError("CoreData: failed to save context: \(error)")
                }
            }
            print("CoreData: saved \(images.count)")
        }
    }
    //Читаем из CoreData
    func readImageListFromStore(by searchString: String) -> [ImageViewModel] {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<MOImage>(entityName: "Image")
        let sortBySearchTag = NSSortDescriptor(key: "searchTag", ascending: true)
        fetchRequest.sortDescriptors = [sortBySearchTag]
        fetchRequest.predicate = NSPredicate(format: "searchTag = %@ and imageData != nil", searchString)
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        do {
            try controller.performFetch()
            let fetchedCount = controller.fetchedObjects?.count ?? 0
            let results = controller.fetchedObjects?.map { (object) -> ImageViewModel in
                let imageDescription = object.imageDescription
                let image = UIImage(data: (object.imageData as NSData) as Data)
                return ImageViewModel(description: imageDescription, image: image!)
            }
            print("CoreData: fetched \(fetchedCount)")
            return results!
        } catch {
            print("CoreData: failed to load context Image for filter" + searchString)
            return []
        }
    }
    /**
     Удаляет все предыдущие сохранения, если они есть
     в текущей реализации не используется, потому что не нужен логически
     но полезен при отладке
     возможно понадобится при проверке - поэтому оставил в виде "пасхалочки"
     вводим текст в поиске: #clear_all_data
     */
    func clearStoredImages() {
        let context = CoreDataStack.shared.persistentContainer.newBackgroundContext()
        let fetchRequest = NSFetchRequest<MOImage>(entityName: "Image")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results {
                context.delete(result)
            }
            do {
                try context.save()
                print("CoreData: removed \(results.count)")
            } catch {
                fatalError("CoreData: failed to save context for remove: \(error)")
            }
        } catch {
            print("CoreData: failed to get images list for delete")
        }
    }
}
