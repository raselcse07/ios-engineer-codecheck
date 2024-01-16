//
//  MockClient.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

import RxTest
import RxSwift
import RxCocoa

class MockClient: APIClientProtocol {
    
    private let session: MockSession
    private let sessionTask: SessionTaskProtocol
    private var storage: [String: MockDataTask] = [:]
    
    init(
        session: MockSession = MockSession(),
        sessionTask: SessionTaskProtocol = SessionTask()
    ) {
        self.session = session
        self.sessionTask = sessionTask
    }
    
    func request<Response>(
        _ endPoint: some APIRequestProtocol,
        decoder: JSONDecoderProtocol = JSONDecoder()
    ) -> Observable<Response> where Response : Decodable {
        request(endPoint).decode(with: decoder)
    }
    
    func request(
        _ endPoint: some APIRequestProtocol
    ) -> Observable<(HTTPURLResponse, Data)> {
        // register data
        session.dataTask = get(for: endPoint)
        return sessionTask
            .execute(with: session, using: endPoint)
            .displayAPIResponse()
            .validate()
            .observe(on: SharingScheduler.make())
    }
}

// MARK: - Register/Unregister Data
extension MockClient {
    
    func register(for endPoint: APIRequestProtocol, with dataTask: MockDataTask) {
        let key = key(for: endPoint)
        guard storage.index(forKey: key) == nil else {
            fatalError("Key \(key) is already registered with anither response!")
        }
        storage[key] = dataTask
    }
    
    func unregister(for endPoint: APIRequestProtocol) {
        let key = key(for: endPoint)
        storage.removeValue(forKey: key)
    }
    
    func unregisterAll() {
        storage.removeAll()
    }
    
    private func get(for endPoint: APIRequestProtocol) -> MockDataTask {
        let key = key(for: endPoint)
        guard let dataTask = storage[key] else {
            fatalError("Data not found for key \(key)")
        }
        return dataTask
    }
    
    private func key(for endPoint: APIRequestProtocol) -> String {
        var key = endPoint.method.rawValue
        key += "-"
        key += endPoint.baseURL.absoluteString
        key += endPoint.path
        return key
    }
}


