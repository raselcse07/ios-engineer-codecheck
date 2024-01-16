//
//  MockSession.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

import Foundation

class MockSession: URLSessionProtocol {
    
    var dataTask: MockDataTask!
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask.completion = completionHandler
        return dataTask
    }
}

