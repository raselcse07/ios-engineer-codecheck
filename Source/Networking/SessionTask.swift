//
//  SessionTask.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift

/// A class responsible for executing session tasks using RxSwift's Observables.
class SessionTask: SessionTaskProtocol {
    /// Executes a session task using the provided URLSession and URLRequestBuildable.
    /// - Parameters:
    ///   - session: The URLSessionProtocol instance to use for the task.
    ///   - request: The URLRequestBuildable instance representing the request to execute.
    /// - Returns: An Observable emitting a tuple containing the HTTPURLResponse and data.
    func execute(
        with session: URLSessionProtocol,
        using request: URLRequestBuildable
    ) -> Observable<(HTTPURLResponse, Data)> {
        return Observable.create { observer in
            do {
                let request = try request.build()
                let task = session.dataTask(with: request) { data, response, error in
                    if let error = error {
                        let error: APIError.SessionTaskError = (error as NSError).code == NSURLErrorNotConnectedToInternet ?
                                                                                        .noInternetConnection : .otherError(error: error)
                        observer.onError(APIError.sessionTaskError(reason: error))
                        return
                    }
                    
                    guard let httpURLResponse = response as? HTTPURLResponse else {
                        observer.onError(APIError.sessionTaskError(reason: .invalidResponse))
                        return
                    }
                    
                    guard let data = data else {
                        observer.onError(APIError.sessionTaskError(reason: .dataError))
                        return
                    }
                    observer.onNext((httpURLResponse, data))
                    observer.onCompleted()
                }
                
                // Dispose the task when the observer is disposed.
                let disposable = Disposables.create {
                    task.cancel()
                }
                
                task.resume()
                return disposable
                
            } catch {
                observer.onError(APIError.sessionTaskError(reason: .invalidRequest))
                return Disposables.create()
            }
        }
    }
}

