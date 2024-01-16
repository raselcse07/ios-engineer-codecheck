//
//  TestCase.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import XCTest

class TestCase: XCTestCase {
    
    func success(result: Codable) throws -> MockDataTask {
        let data = try JSONEncoder().encode(result)
        return MockDataTask.success(with: data)
    }
    
    func failed(error: Error) throws -> MockDataTask {
        return MockDataTask.failed(with: error)
    }
    
    func XCTAssertOfType<T>(_ value: Any,
                         _: T.Type,
                         _ message: @autoclosure () -> String = "",
                         file: StaticString = #filePath,
                         line: UInt = #line) {
        XCTAssertNotNil(value as? T, message(), file: file, line: line)
    }
    
}
