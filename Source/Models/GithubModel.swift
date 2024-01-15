//
//  GithubModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

// MARK: - GithubModel
struct GithubModel: Decodable {
    
    let totalCount: Int
    let items: [GithubItem]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

// MARK: - Item
struct GithubItem: Decodable {
    
    let name: String?
    let fullName: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
