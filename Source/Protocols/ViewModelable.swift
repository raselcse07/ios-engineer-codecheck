//
//  ViewModelable.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

/// A protocol defining a standardized interface for view controllers that can be associated with a view model.
protocol ViewModelable {
    /// The type of the associated view model.
    associatedtype ViewModelType
    
    /// The associated view model instance.
    var viewModel: ViewModelType! { get set }
    
    /// Binds the view controller to the specified view model.
    /// - Parameter viewModel: The view model to be associated with the view controller.
    mutating func bind(to viewModel: ViewModelType)
}

extension ViewModelable where Self: UIViewController {
    /// Default implementation of binding the view controller to the specified view model.
    /// - Parameter viewModel: The view model to be associated with the view controller.
    mutating func bind(to viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}

