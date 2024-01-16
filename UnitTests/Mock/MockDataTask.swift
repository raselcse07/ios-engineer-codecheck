//
//  MockDataTask.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

import Foundation

class MockDataTask: URLSessionDataTaskProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    func resume() {
        completion?(data, response, error)
    }
    
    func cancel() {
        data = nil
        response = nil
        error = nil
    }
}

extension MockDataTask {
    
    static func success(with data: Data) -> MockDataTask {
        let task = MockDataTask()
        task.data = data
        task.response = HTTPURLResponse(url: URL(fileURLWithPath: ""),
                                        statusCode: 200,
                                        httpVersion: nil,
                                        headerFields: nil)
        return task
    }
    
    static func failed(with error: Error) -> MockDataTask {
        let task = MockDataTask()
        task.error = error
        task.response = HTTPURLResponse(url: URL(fileURLWithPath: ""),
                                        statusCode: (error as NSError).code,
                                        httpVersion: nil,
                                        headerFields: nil)
        return task
    }
}


