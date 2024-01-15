//
//  SessionTaskProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift

/// A protocol defining a standardized interface for executing session tasks using RxSwift.
protocol SessionTaskProtocol {
    /// Executes a session task using the provided URLSession and URLRequestBuildable.
    /// - Parameters:
    ///   - session: The URLSessionProtocol instance to use for the task.
    ///   - request: The URLRequestBuildable instance representing the request to execute.
    /// - Returns: An Observable emitting a tuple containing the HTTPURLResponse and data.
    func execute(
        with session: URLSessionProtocol,
        using request: URLRequestBuildable
    ) -> Observable<(HTTPURLResponse, Data)>
}
