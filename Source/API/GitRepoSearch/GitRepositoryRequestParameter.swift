//
//  GitRepositoryRequestParameter.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GitRepositoryRequestParameter: Encodable {
    
    let query: String
    
    private enum CodingKeys: String, CodingKey {
        case query = "q"
    }
}
