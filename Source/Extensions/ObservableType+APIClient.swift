//
//  ObservableType+APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift

extension ObservableType where Element == (HTTPURLResponse, Data) {
    /// Validates the response status code falls within the range 200..<300.
    /// - Returns: An Observable emitting the validated response.
    func validate() -> Observable<Element> {
        flatMap { response -> Observable<Element> in
            if (200 ..< 300) ~= response.0.statusCode {
                return .just(response)
            } else if response.0.statusCode == 403 {
                return .error(APIError.sessionTaskError(reason: .rateLimitError))
            } else {
                return .error(APIError.sessionTaskError(reason: .unexpectedError))
            }
        }
    }
    
    /// Decodes the response data into a Codable object using the provided JSON decoder.
    /// - Parameters:
    ///   - decoder: The JSONDecoderProtocol instance to use for decoding.
    /// - Returns: An Observable emitting the decoded object.
    func decode<T>(with decoder: JSONDecoderProtocol) -> Observable<T> where T: Decodable {
        flatMap { _, data -> Observable<T> in
            do {
                let decoded = try decoder.decode(T.self, from: data)
                return .just(decoded)
            } catch {
                return .error(APIError.sessionTaskError(reason: .decodeError(error: error)))
            }
        }
    }
    
    /// Prints debugging information for the response (available only in DEBUG builds).
    /// - Returns: An Observable emitting the response.
    func displayAPIResponse() -> Observable<Element> {
        #if DEBUG
        return self.do(onNext: { tuple in
            let (response, data) = tuple
            print("=============================================================================")
            print("URL = \(response.url?.absoluteString ?? "")")
            print("STATUS CODE = \(response.statusCode)")
            print("HEADERS = \(response.allHeaderFields)")
            print("JSON = \(try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed))")
            print("=============================================================================")
        })
        #endif
    }
}

