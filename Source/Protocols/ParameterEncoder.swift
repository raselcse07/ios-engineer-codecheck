//
//  ParameterEncoder.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// A protocol defining a standardized interface for encoding parameters into a URLRequest using a Codable type.
protocol ParameterEncoder {
    /// Encodes the provided parameters into a URLRequest.
    /// - Parameters:
    ///   - parameters: The Encodable parameters to be encoded into the URLRequest.
    ///   - request: The URLRequest instance to be modified.
    /// - Returns: A URLRequest with the encoded parameters.
    /// - Throws: An error if there are issues during the encoding process.
    func encode<Parameters>(
        _ parameters: Parameters?,
        into request: URLRequest
    ) throws -> URLRequest where Parameters: Encodable
}

