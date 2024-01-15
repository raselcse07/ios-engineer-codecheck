//
//  URLRequest+Ext.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

extension URLRequest {
    
    mutating func setHeaders(with headers: Headers) {
        headers.forEach { key, value in
            setValue(value, forHTTPHeaderField: key)
        }
    }
}
