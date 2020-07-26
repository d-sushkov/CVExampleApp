//
//  ImageProcessing.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 24.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import UIKit
import Nuke

extension RepoModel {
//    CONFIGURE CACHE!!!!
//    ImageCache.shared.costLimit = 1024 * 1024 * 50
//    ImageCache.shared.ttl = 60
    func loadImage(to cell: RepositoryCell) {
        if let data = self.userAvatarData {
            cell.userAvatarView.layer.cornerRadius = cell.userAvatarView.bounds.height / 2
            cell.userAvatarView.image = UIImage(data: data)
        } else {
            if let avatarURL = self.userAvatarURL {
                let request = ImageRequest(url: avatarURL, processors: [ImageProcessors.Resize(size: CGSize(width: cell.pixelSize, height: cell.pixelSize), contentMode: .aspectFill), ImageProcessors.Circle()
                ])
                Nuke.loadImage(with: request, into: cell.userAvatarView)
                DispatchQueue.global().async {
                    self.saveImageToStorage(url: avatarURL)
                }
            }
        }
    }
    
    func loadImage(to view: UIImageView) {
        if let data = self.userAvatarData {
            view.image = UIImage(data: data)
        } else {
            if let avatarURL = self.userAvatarURL {
                Nuke.loadImage(with: avatarURL, into: view)
            }
        }
    }
    
    func saveImageToStorage(url: URL) {
        let request = URLRequest(url: url)
        let data = DataLoader.sharedUrlCache.cachedResponse(for: request)?.data
        self.userAvatarData = data
    }
    
}
