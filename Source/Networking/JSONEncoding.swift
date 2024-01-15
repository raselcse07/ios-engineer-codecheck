//
//  JSONEncoding.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// A parameter encoder implementation that encodes parameters into a URLRequest using JSON format.
class JSONEncoding: ParameterEncoder {
    
    private let encoder: JSONEncoder
    
    /// Initializes the JSONEncoding instance with an optional JSONEncoder.
    /// - Parameter encoder: The JSONEncoder instance to use for encoding (optional, default is a new JSONEncoder).
    init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }
    
    /// Encodes the provided parameters into a URLRequest using JSON format.
    /// - Parameters:
    ///   - parameters: The Encodable parameters to be encoded into the URLRequest.
    ///   - request: The URLRequest instance to be modified.
    /// - Returns: A URLRequest with the encoded parameters.
    /// - Throws: An error if there are issues during the encoding process.
    func encode<Parameters>(
        _ parameters: Parameters?,
        into request: URLRequest
    ) throws -> URLRequest where Parameters : Encodable {
        
        // Check if parameters are provided, if not, return the original request.
        guard let parameters = parameters else {
            return request
        }
        
        var urlRequest = request
        
        do {
            let data = try encoder.encode(parameters)
            
            urlRequest.httpBody = data
    
            // Set Content-Type header if not already set.
            if urlRequest.allHTTPHeaderFields?["Content-Type"] == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        } catch {
            throw APIError.parameterEncodingError(reason: .jsonEncodingFailed)
        }
        
        return urlRequest
    }
}

