//
//  APICommunicatingViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift

/// A protocol defining a standardized interface for view models that communicate with an API client.
protocol APICommunicatingViewModel {
    /// The API client used for making API requests.
    var apiClient: APIClientProtocol { get set }
}

extension APICommunicatingViewModel where Self: BaseViewModel {
    /// Executes an API request using the specified API request object.
    /// - Parameters:
    ///   - request: The API request to be executed.
    ///   - decoder: The JSONDecoderProtocol instance to use for decoding (optional, default is JSONDecoder()).
    /// - Returns: An Observable emitting the decoded response.
    func doAPIRequest<Request: APIRequestWithResponse>(
        _ request: Request,
        decoder: JSONDecoderProtocol = JSONDecoder()
    ) -> Observable<Request.Response> {
        apiClient.request(request, decoder: decoder)
            .map { $0 as Request.Response }
            .sinkErrorMessage(into: messageSinkRelay)
            .trackActivity(activityIndicator)
    }
}

