//
//  StoryboardInstantiable.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

/// A protocol defining a standardized interface for view controllers that can be instantiated from storyboards.
protocol StoryboardInstantiable {
    /// The unique identifier for the view controller's storyboard.
    static var storyboardIdentifier: String { get }
    
    /// Creates an instance of the view controller from the storyboard.
    /// - Returns: An instance of the view controller.
    static func instantiateViewController<T>() -> T where T: StoryboardInstantiable
}

extension StoryboardInstantiable where Self: UIViewController {
    /// The default implementation for the view controller's storyboard identifier.
    static var storyboardIdentifier: String {
        "\(Self.self)"
    }
    
    /// The storyboard associated with the view controller.
    static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardIdentifier, bundle: nil)
    }
    
    /// Creates an instance of the view controller from the storyboard.
    /// - Returns: An instance of the view controller.
    static func instantiateViewController<T>() -> T where T: StoryboardInstantiable {
        storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
    }
}

extension UIViewController: StoryboardInstantiable {}
