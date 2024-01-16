//
//  ImageWithTextView.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

class ImageWithTextView: UIView, XibView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Initialization
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setup(with image: UIImage, attributedString: NSAttributedString) {
        iconView.image = image
        titleLabel.attributedText = attributedString
    }
}
