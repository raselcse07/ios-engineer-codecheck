//
//  Alert.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

struct Alert {
    
    static func show(
        title: String? = nil,
        message: String? = nil,
        in controller: UIViewController? = AppUtil.topViewController()
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constant.Text.OK, style: .default)
        alertController.addAction(alertAction)
        controller?.present(alertController, animated: true)
    }
}
