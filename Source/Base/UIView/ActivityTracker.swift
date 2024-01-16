//
//  ActivityTracker.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

class ActivityTracker: UIView, XibView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = .black
            activityIndicator.startAnimating()
        }
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        backgroundColor = .black.withAlphaComponent(0.3)
        layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        backgroundColor = .black.withAlphaComponent(0.3)
        layer.cornerRadius = 8
    }
}
