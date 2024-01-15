//
//  APIRequestProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

/// A protocol defining a standardized interface for building API requests.
protocol APIRequestProtocol: URLRequestBuildable {
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var headers: Headers? { get }
}

extension APIRequestProtocol {
    
    /// Constructs the complete URL by appending the path to the baseURL.
    fileprivate var completeURL: URL {
        if #available(iOS 16.0, *) {
            return baseURL.appending(path: path)
        } else {
            return baseURL.appendingPathComponent(path)
        }
    }
    
    /// Builds and returns a URLRequest instance based on the API request specifications.
    /// - Returns: A URLRequest instance.
    /// - Throws: An error if there are issues during the URLRequest creation process.
    func build() throws -> URLRequest {
        var request = URLRequest(url: completeURL)
        request.httpMethod = method.rawValue
        // set headers
        if let headers = headers {
            request.setHeaders(with: headers)
        }
        return request
    }
}

/// A protocol defining API requests that expect a response.
protocol APIRequestWithResponse: APIRequestProtocol {
    associatedtype Response: Decodable
}

/// A protocol defining API requests that require parameters for the request.
protocol APIRequestWithParameter: APIRequestProtocol {
    associatedtype Parameter: Encodable
    var parameter: Parameter { get }
    var parameterEncoder: ParameterEncoder { get }
}

extension APIRequestWithParameter {
    /// Builds and returns a URLRequest instance based on the API request specifications, including parameter encoding.
    /// - Returns: A URLRequest instance.
    /// - Throws: An error if there are issues during the URLRequest creation or parameter encoding process.
    func build() throws -> URLRequest {
        var request = URLRequest(url: completeURL)
        request.httpMethod = method.rawValue
        // set headers
        if let headers = headers {
            request.setHeaders(with: headers)
        }
        return try parameterEncoder.encode(parameter, into: request)
    }
}

/// A protocol combining API requests with both parameter and response expectations.
protocol APIRequestWithParameterAndResponse: APIRequestWithParameter, APIRequestWithResponse { }

