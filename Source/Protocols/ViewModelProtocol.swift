//
//  ViewModelProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import Foundation

/// A protocol defining a standardized interface for view model objects.
protocol ViewModelProtocol {
    /// The input data structure expected by the view model.
    associatedtype Input
    
    /// The output data structure produced by the view model.
    associatedtype Output
    
    /// The input data to be provided to the view model.
    var input: Input! { get set }
    
    /// The output data produced by the view model.
    var output: Output! { get set }
    
    /// Binds the input and output data structures to enable communication between the view and view model.
    func bind()
}

