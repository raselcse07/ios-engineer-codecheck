//
//  XibView.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

/// A protocol for creating a view from a XIB file.
protocol XibView: UIView {
    /// The main content view loaded from the XIB file.
    var contentView: UIView! { get }
    /// Initializes a view using the specified frame.
    /// - Parameter frame: The frame rectangle for the view.
    init(frame: CGRect)
    /// Initializes a view using data from the specified coder.
    /// - Parameter coder: An unarchiver object.
    init?(coder: NSCoder)
    /// Common initialization method to load and configure the content view from the XIB file.
    func commonInit()
}

extension XibView {
    /// Common initialization method to load and configure the content view from the XIB file.
    func commonInit() {
        Bundle.main.loadNibNamed("\(Self.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

