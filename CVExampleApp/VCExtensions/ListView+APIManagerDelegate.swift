//
//  APIManagerDelegate.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 25.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import Foundation

extension ListViewController: APIManagerDelegate {
    
    func didUpdateData(_ apiManager: APIManager, results: [RepoModel]) {
        DispatchQueue.main.async {
            if self.dataFromAPI.isEmpty {
                do {
                    try apiManager.childContext.save()
                    self.loadItems(from: self.context)
                } catch {
                    print("ERROR saving Child context")
                }
            } else {
                self.updateItems(with: results)
            }
            self.hapticGenerator.impactOccurred()
            self.pullToRefreshControl.endRefreshing()
        }
    }
    
    func didFailWithError(error: Error) {
        hapticGenerator.impactOccurred()
        pullToRefreshControl.endRefreshing()
        print(error)
    }
}
