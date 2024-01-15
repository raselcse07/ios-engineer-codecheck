//
//  APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa

/// A class responsible for making API requests using RxSwift and RxCocoa.
final class APIClient {
    
    private let session: URLSessionProtocol
    private let sessionTask: SessionTaskProtocol
    
    /// Initializes the APIClient with optional session and session task instances.
    /// - Parameters:
    ///   - session: The URLSessionProtocol instance to use for network requests.
    ///   - sessionTask: The SessionTaskProtocol instance to execute session tasks.
    init(
        session: URLSessionProtocol = URLSession(configuration: .default),
        sessionTask: SessionTaskProtocol = SessionTask()
    ) {
        self.session = session
        self.sessionTask = sessionTask
    }
}

// MARK: - APIClient + APIClientProtocol
extension APIClient: APIClientProtocol {
    /// Makes an API request using the specified endpoint and decodes the response into a Decodable object.
    /// - Parameters:
    ///   - endPoint: The APIRequestProtocol instance representing the endpoint to request.
    ///   - decoder: The JSONDecoderProtocol instance to use for decoding (optional, default is JSONDecoder()).
    /// - Returns: An Observable emitting the decoded object.
    func request<Response>(
        _ endPoint: some APIRequestProtocol,
        decoder: JSONDecoderProtocol = JSONDecoder()
    ) -> Observable<Response> where Response : Decodable {
        request(endPoint).decode(with: decoder)
    }
    
    /// Makes an API request using the specified endpoint and returns the raw HTTPURLResponse and data.
    /// - Parameter endPoint: The APIRequestProtocol instance representing the endpoint to request.
    /// - Returns: An Observable emitting a tuple containing the HTTPURLResponse and data.
    func request(
        _ endPoint: some APIRequestProtocol
    ) -> Observable<(HTTPURLResponse, Data)> {
        sessionTask
            .execute(with: session, using: endPoint)
            .displayAPIResponse()
            .validate()
            .observe(on: MainScheduler.instance)
    }
}

