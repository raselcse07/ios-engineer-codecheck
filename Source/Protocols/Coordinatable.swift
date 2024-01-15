//
//  Coordinatable.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

/// A protocol defining a standardized interface for view controllers that can be associated with a coordinator.
protocol Coordinatable {
    /// The type of the associated coordinator.
    associatedtype CoordinatorType
    
    /// The associated coordinator instance.
    var coordinator: CoordinatorType? { get set }
    
    /// Registers an associated coordinator with the view controller.
    /// - Parameter coordinator: The coordinator to be associated with the view controller.
    mutating func register(to coordinator: CoordinatorType)
}

extension Coordinatable where Self: UIViewController {
    /// Default implementation of registering an associated coordinator with the view controller.
    /// - Parameter coordinator: The coordinator to be associated with the view controller.
    mutating func register(to coordinator: CoordinatorType) {
        self.coordinator = coordinator
    }
}
