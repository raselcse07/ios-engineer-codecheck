//
//  UIImageView+Ext.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(url: URL?, placeholder: UIImage? = nil) {
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .transition(.fade(0.5))
            ]
        )
    }
    
    func setImage(urlString: String, placeholder: UIImage? = nil) {
        setImage(url: URL(string: urlString), placeholder: placeholder)
    }
}
