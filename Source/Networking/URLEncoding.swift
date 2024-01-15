//
//  URLEncoding.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// **Warning:** This parameter encoder implementation supports encoding parameters only into the query string.
class URLEncoding: ParameterEncoder {
    
    private let encoder: JSONEncoder
    
    /// Initializes the JSONEncoding instance with an optional JSONEncoder.
    /// - Parameter encoder: The JSONEncoder instance to use for encoding (optional, default is a new JSONEncoder).
    init(encoder: JSONEncoder = JSONEncoder()) {
        self.encoder = encoder
    }
    
    /// Encodes the provided parameters into the query string of a URLRequest's URL.
    /// - Parameters:
    ///   - parameters: The Encodable parameters to be encoded into the query string.
    ///   - request: The URLRequest instance to be modified.
    /// - Returns: A URLRequest with the encoded query string parameters.
    /// - Throws: An error if there are issues during the encoding process, such as a missing URL or dictionary conversion error.
    func encode<Parameters>(
        _ parameters: Parameters?,
        into request: URLRequest
    ) throws -> URLRequest where Parameters : Encodable {
        
        // Check if parameters are provided, if not, return the original request.
        guard let parameters = parameters else {
            return request
        }
        
        var urlRequest = request
        
        // Ensure the URL is present.
        guard let url = urlRequest.url else {
            throw APIError.parameterEncodingError(reason: .missingURL)
        }
        
        do {
            let data = try encoder.encode(parameters)
            
            // Convert encoded data to a dictionary.
            guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                throw APIError.parameterEncodingError(reason: .dictConversionError)
            }
            
            // Create URL components and set query items.
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = jsonObject.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            
            // Ensure the new URL is valid.
            guard let newURL = components?.url else {
                throw APIError.parameterEncodingError(reason: .invalidURL)
            }
            
            urlRequest.url = newURL
            
        } catch {
            throw APIError.parameterEncodingError(reason: .jsonEncodingFailed)
        }
        
        return urlRequest
    }
}

