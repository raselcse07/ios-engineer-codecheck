//
//  GitRepositoryRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GitRepositoryRequest: APIRequestWithParameterAndResponse {
    
    typealias Response = GithubModel
    
    var parameter: GitRepositoryRequestParameter

    var baseURL: URL {
        URL(string: Constant.Networking.githubRepoSearchBaseURL)!
    }
    
    var path: String {
        Constant.Networking.githubRepoSearchPath
    }
    
    var method: Method {
        .GET
    }
    
    var headers: Headers? {
        nil
    }
    
    var parameterEncoder: ParameterEncoder {
        URLEncoding()
    }
}
