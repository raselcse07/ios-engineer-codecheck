//
//  APIError.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

// MARK: - APIError
/// An enumeration representing various API-related errors.
enum APIError: Error {
    /// An error that occurred during a session task.
    case sessionTaskError(reason: SessionTaskError)
    
    /// An error that occurred during parameter encoding.
    case parameterEncodingError(reason: ParameterEncodingError)
}

// MARK: - APIError.SessionTaskError
extension APIError {
    /// An enumeration representing session task errors.
    enum SessionTaskError  {
        case invalidRequest
        case invalidResponse
        case dataError
        case decodeError(error: Error)
        case unexpectedError
        case noInternetConnection
        case rateLimitError
        case otherError(error: Error)
    }
}

// MARK: - APIError.ParameterEncodingError
extension APIError {
    /// An enumeration representing parameter encoding errors.
    enum ParameterEncodingError {
        case jsonEncodingFailed
        case missingURL
        case dictConversionError
        case invalidURL
    }
}

// MARK: - APIError + LocalizedError
extension APIError: LocalizedError {
    /// A localized description of the API error.
    var errorDescription: String? {
        switch self {
        case let .sessionTaskError(reason):
            return reason.errorDescription
        case let .parameterEncodingError(reason):
            return reason.errorDescription
        }
    }
}

// MARK: - APIError.SessionTaskError + LocalizedError
extension APIError.SessionTaskError: LocalizedError {
    /// A localized description of the session task error.
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "SessionTaskError: Invalid request."
        case .invalidResponse:
            return "SessionTaskError: Invalid response."
        case .dataError:
            return "SessionTaskError: Invalid data."
        case let .decodeError(error):
            return "SessionTaskError: \(error)"
        case .unexpectedError:
            return "SessionTaskError: Unexpected Error!"
        case .noInternetConnection:
            return "SessionTaskError: No internet connection!"
        case .rateLimitError:
            return "API rate limit exceeded!"
        case .otherError(let error):
            return "SessionTaskError: \(error.localizedDescription)"
        }
    }
}

// MARK: - APIError.ParameterEncodingError + LocalizedError
extension APIError.ParameterEncodingError: LocalizedError {
    /// A localized description of the parameter encoding error.
    var errorDescription: String? {
        switch self {
        case .jsonEncodingFailed:
            return "ParameterEncodingError: JSON encoding failed."
        case .missingURL:
            return "ParameterEncodingError: URL missing."
        case .dictConversionError:
            return "ParameterEncodingError: Failed to convert JSON object to dictionary"
        case .invalidURL:
            return "ParameterEncodingError: Invalid URL."
        }
    }
}

