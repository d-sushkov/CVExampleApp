//
//  EmailAndWeb.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 25.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import Foundation
import SafariServices
import MessageUI

extension DetailViewController: MFMailComposeViewControllerDelegate {
    
    func urlChecking(url: URL) {
        if (url.scheme?.contains("mailto"))! {
            let address = URLComponents(url: url, resolvingAgainstBaseURL: false)?.path
            if let email = address {
                openMFMail(email: email)
            }
        } else {
            loadWebPage(urlString: url.absoluteString)
        }
    }
    
    private func loadWebPage(urlString: String?) {
        guard let safeString = urlString else {return}
        if let url = URL(string: safeString) {
            let webVC = SFSafariViewController(url: url)
            present(webVC, animated: true)
        }
    }
    private func openMFMail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients([email])
            present(mailComposer, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
