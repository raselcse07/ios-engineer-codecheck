//
//  APIClientProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa

/// A protocol defining a standardized interface for making API requests using RxSwift and RxCocoa.
protocol APIClientProtocol {
    /// Makes an API request and decodes the response into a Decodable object.
    /// - Parameters:
    ///   - endPoint: The APIRequestProtocol instance representing the endpoint to request.
    ///   - decoder: The JSONDecoderProtocol instance to use for decoding.
    /// - Returns: An Observable emitting the decoded object.
    func request<Response>(
        _ endPoint: some APIRequestProtocol,
        decoder: JSONDecoderProtocol
    ) -> Observable<Response> where Response: Decodable
    
    /// Makes an API request and returns the raw HTTPURLResponse and data.
    /// - Parameter endPoint: The APIRequestProtocol instance representing the endpoint to request.
    /// - Returns: An Observable emitting a tuple containing the HTTPURLResponse and data.
    func request(
        _ endPoint: some APIRequestProtocol
    ) -> Observable<(HTTPURLResponse, Data)>
}

