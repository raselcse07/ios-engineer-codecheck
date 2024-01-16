//
//  UIFont.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIFont {
    
    static var regularCaption: UIFont {
        .systemFont(ofSize: 18, weight: .regular)
    }
    
    static var largeBoldCaption: UIFont {
        .systemFont(ofSize: 30, weight: .bold)
    }
    
    static var boldCaption: UIFont {
        .systemFont(ofSize: 18, weight: .bold)
    }
    
    static var smallCaption: UIFont {
        .systemFont(ofSize: 10, weight: .regular)
    }
    
    static var mediumCaption: UIFont {
        .systemFont(ofSize: 14, weight: .regular)
    }
    
    static var thinCaption: UIFont {
        .systemFont(ofSize: 10, weight: .thin)
    }
}
