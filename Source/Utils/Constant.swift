//
//  Constant.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Constant {
    
    // MARK: - Text
    struct Text {
        static let repoSearchNavigationItemTitle = "GitHubのリポジトリを探す"
        static let repoSearchPlaceHolder = "GitHubのリポジトリを検索できるよー"
    }
    
    // MARK: - Networking
    struct Networking {
        static let githubRepoSearchBaseURL = "https://api.github.com"
        static let githubRepoSearchPath = "/search/repositories"
    }
}
