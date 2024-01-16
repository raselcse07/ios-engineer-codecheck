//
//  String+Ext.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

// MARK: - Convert to Attributed String
extension String {
    
    /// Generates a mutable attributed string with specified font and color.
    ///
    /// - Parameters:
    ///   - font: The font to be applied to the attributed string.
    ///   - color: The color to be applied to the attributed string.
    /// - Returns: A mutable attributed string with the specified font and color.
    func attributed(font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        attributedString.setAttributes(attributes, range: NSRange(location: 0, length: utf16.count))
        return attributedString
    }
}

