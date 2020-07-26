//
//  DetailView+TextViewDelegate.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 26.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import UIKit

extension DetailViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        urlChecking(url: URL)
        return false
    }
}
