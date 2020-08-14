//
//  APIManager.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 17.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import UIKit
import CoreData

protocol APIManagerDelegate: class {
    func didUpdateData(_ apiManager: APIManager, results: [RepoModel])
    func didFailWithError(error: Error)
}

struct APIManager {
    
    weak var delegate: APIManagerDelegate?
    
    let childContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    
    private var apiURL: String {
        return "https://api.github.com/repositories?since=\(Int.random(in: 1...99999999))"
    }
    
    func performRequest() {
        if let url = URL(string: apiURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let results = self.parseJSON(safeData) {
                        self.delegate?.didUpdateData(self, results: results)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ apiData: Data) -> [RepoModel]? {
        childContext.reset()
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([APIData].self, from: apiData)
            var results = [RepoModel]()
            for repository in decodedData {
                let result = RepoModel(context: childContext)
                result.repName = repository.name
                result.repDescription = repository.description
                result.repURLString = repository.htmlURL
                result.userName = repository.owner.login
                result.userType = repository.owner.type
                result.userAvatarURL = URL(string: repository.owner.avatarURL)
                results.append(result)
            }
            return results
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}

