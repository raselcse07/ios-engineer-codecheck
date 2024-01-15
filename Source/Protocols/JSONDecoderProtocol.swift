//
//  JSONDecoderProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// A protocol defining a standardized interface for JSON decoding.
protocol JSONDecoderProtocol {
    /// Decodes a given type from the provided JSON data.
    /// - Parameters:
    ///   - type: The type to decode. Must conform to `Decodable`.
    ///   - data: The JSON data to decode.
    /// - Returns: An instance of the specified type, decoded from the JSON data.
    /// - Throws: An error if the decoding process encounters any issues.
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: JSONDecoderProtocol { }

