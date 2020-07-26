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
    let htmlURL: String
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, owner, htmlURL = "html_url", description
    }
}

struct Owner: Codable {
    let login: String
    let avatarURL: String
    let type: String
    
    private enum CodingKeys: String, CodingKey {
        case login, avatarURL = "avatar_url", type
    }
}
