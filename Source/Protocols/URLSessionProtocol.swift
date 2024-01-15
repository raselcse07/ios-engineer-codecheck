//
//  URLSessionProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// A protocol defining a standardized interface for URLSession data tasks.
protocol URLSessionProtocol {
    /// Creates a data task with the specified request.
    /// - Parameters:
    ///   - request: The URLRequest to be used for the data task.
    ///   - completionHandler: The closure to be executed when the task completes.
    /// - Returns: An instance conforming to `URLSessionDataTaskProtocol`.
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
