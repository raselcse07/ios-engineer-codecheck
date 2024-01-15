//
//  URLSessionDataTaskProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// A protocol defining a standardized interface for URLSession data tasks.
protocol URLSessionDataTaskProtocol {
    /// Resumes the task, starting or resuming its execution.
    func resume()
    
    /// Cancels the task, stopping its execution if it's currently running.
    func cancel()
}


extension URLSessionDataTask: URLSessionDataTaskProtocol { }

