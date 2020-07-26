//
//  RepositoryCell.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 18.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var repNameLabel: UILabel!
    
    @IBOutlet weak var userAvatarView: UIImageView!
    
    var pixelSize: CGFloat {
        get {
            return self.layer.frame.height * UIScreen.main.scale
        }
    }
    
}
