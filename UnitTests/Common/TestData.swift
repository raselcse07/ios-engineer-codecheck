//
//  TestData.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

import Foundation

struct TestData {
    
    static var githubModel: GithubModel {
        GithubModel(
            totalCount: 2,
            items: [
                GithubItem(
                    id: 1,
                    name: "Swift",
                    fullName: "Apple/Swift",
                    owner: GithubItemOwner(avatarURL: "https://test.jp"),
                    stargazersCount: 1000,
                    watchersCount: 5000,
                    forksCount: 900,
                    openIssuesCount: 100,
                    language: "C++"
                ),
                GithubItem(
                    id: 2,
                    name: "SwiftUI",
                    fullName: "Apple/SwiftUI",
                    owner: GithubItemOwner(avatarURL: "https://test.jp"),
                    stargazersCount: 200,
                    watchersCount: 400,
                    forksCount: 800,
                    openIssuesCount: 600,
                    language: "Swift"
                )
            ]
        )
    }
}
