//
//  APIData.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 17.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import Foundation

struct APIData: Codable {
    let name: String
    let owner: Owner
    let html_url: String
    let description: String?
}

struct Owner: Codable {
    let login: String
    let avatar_url: String
    let type: String
}
