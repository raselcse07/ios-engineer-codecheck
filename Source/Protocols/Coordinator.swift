//
//  Coordinator.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

/// A protocol defining a standardized interface for coordinator objects.
protocol Coordinator: AnyObject {
    /// The navigation controller used for managing the coordinated flow.
    var navigationController: UINavigationController { get set }
    
    /// Initializes a coordinator with the specified navigation controller.
    /// - Parameter navigationController: The navigation controller to be used for the coordinated flow.
    init(navigationController: UINavigationController)
    
    /// Starts the coordination process and returns the root view controller of the coordinated flow.
    /// - Returns: The root view controller of the coordinated flow.
    @discardableResult func start() -> UIViewController
}
