//
//  ModelManipulation.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 25.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import Foundation
import CoreData

extension ListViewController {
    
    private func saveItems() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
        tableView.reloadData()
    }
    
    func loadItems(from context: NSManagedObjectContext) {
        let request: NSFetchRequest<RepoModel> = RepoModel.fetchRequest()
        do {
            dataFromAPI = try context.fetch(request)
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
    
    func updateItems(with newModel: [RepoModel]) {
        for (index, item) in newModel.enumerated() {
            if index < dataFromAPI.count {
                dataFromAPI[index].setValue(item.repName, forKey: "repName")
                dataFromAPI[index].setValue(item.repDescription, forKey: "repDescription")
                dataFromAPI[index].setValue(item.repURLString, forKey: "repURLString")
                dataFromAPI[index].setValue(item.userName, forKey: "userName")
                dataFromAPI[index].setValue(item.userType, forKey: "userType")
                dataFromAPI[index].setValue(item.userAvatarURL, forKey: "userAvatarURL")
                dataFromAPI[index].setValue(nil, forKey: "userAvatarData")
            }
        }
        dataFromAPI[0].clearImageCache()
        saveItems()
    }
}
