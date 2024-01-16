//
//  GithubModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxDataSources

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
    
    let id: Int
    let name: String?
    let fullName: String
    let owner: GithubItemOwner
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let language: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
    }
}

// MARK: - Owner
struct GithubItemOwner: Decodable {
    
    let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}

// MARK: - GithubItem + Equatable
extension GithubItem: Equatable {
    
    static func == (lhs: GithubItem, rhs: GithubItem) -> Bool {
        lhs.id == rhs.id && lhs.fullName == rhs.fullName
    }
}

// MARK: - GithubItem + IdentifiableType
extension GithubItem: IdentifiableType {
    
    var identity: Int {
        id
    }
}
