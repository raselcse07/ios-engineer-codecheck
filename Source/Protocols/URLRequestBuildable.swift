//
//  URLRequestBuildable.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// A protocol defining a standardized interface for building URLRequest instances.
protocol URLRequestBuildable {
    /// Builds and returns a URLRequest instance.
    /// - Returns: A URLRequest instance.
    /// - Throws: An error if there are issues during the URLRequest creation process.
    func build() throws -> URLRequest
}

