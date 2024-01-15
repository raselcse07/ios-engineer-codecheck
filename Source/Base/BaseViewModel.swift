//
//  BaseViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
    let activityIndicator = ActivityIndicator()
    let messageSinkRelay = BehaviorRelay<String?>(value: nil)
}
