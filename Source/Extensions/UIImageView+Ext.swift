//
//  UIImageView+Ext.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

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

// MARK: - Reactive
extension Reactive where Base: UIImageView {
    
    var setImage: Binder<String> {
        Binder(base) { base, urlString in
            base.setImage(
                urlString: urlString,
                placeholder: UIImage(named: Constant.LocalImageName.placeholder)
            )
        }
    }
}
