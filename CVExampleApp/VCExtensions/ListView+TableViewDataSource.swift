//
//  TableViewDataSource.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 25.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import UIKit

extension ListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataFromAPI.isEmpty {
            return 1
        } else {
            return dataFromAPI.count
        }
    }
    
    func registerRepositoryCell() {
        let repositoryCell = UINib(nibName: "RepositoryCell", bundle: nil)
        tableView.register(repositoryCell, forCellReuseIdentifier: "cell")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataFromAPI.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
            cell.textLabel?.text = "No data. Pull to refresh"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryCell
            cell.repNameLabel?.text = dataFromAPI[indexPath.row].repName
            dataFromAPI[indexPath.row].loadImage(to: cell)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCell = dataFromAPI[indexPath.row]
        performSegue(withIdentifier: "goToDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
