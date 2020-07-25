//
//  DetailViewController.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 17.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {
    
    var selectedItem: RepoModel?
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var webLinkTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adjustLargeTitleSize()
        if let safeItem = selectedItem {
            safeItem.loadImage(to: userAvatarImageView)
            userNameLabel.text = "by \(safeItem.userName ?? "unknown_user")"
            userTypeLabel.text = "GitHub \(safeItem.userType ?? "User")"
            descriptionTextView.text = safeItem.repDescription
            webLinkTextView.isSelectable = true
            webLinkTextView.text = safeItem.repURLString
        }
    }
    
    @IBAction func webLinkTapped(_ sender: Any) {
        loadWebPage(urlString: webLinkTextView.text)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        urlChecking(url: URL)
        return false
    }
}