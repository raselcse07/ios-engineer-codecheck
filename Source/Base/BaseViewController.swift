//
//  BaseViewController  .swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    fileprivate func displayActivityTracker() {
        guard let keyWindow = AppUtil.keyWindow else { return }
        let activityTracker = ActivityTracker()
        keyWindow.addSubview(activityTracker)
        
        // set constraint
        activityTracker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityTracker.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
            activityTracker.centerYAnchor.constraint(equalTo: keyWindow.centerYAnchor),
            activityTracker.heightAnchor.constraint(equalToConstant: 100),
            activityTracker.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    fileprivate func removeActivityTracker() {
        guard let keyWindow = AppUtil.keyWindow else { return }
        let trackers = keyWindow.subviews.filter { $0 is ActivityTracker }
        trackers.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - Reactive
extension Reactive where Base: BaseViewController {
    
    var viewDidAppear: Observable<Void> {
        sentMessage(#selector(base.viewDidAppear(_:))).mapToVoid()
    }
    
    var isBusy: Binder<Bool> {
        Binder(base) { base, busy in
            if busy {
                base.displayActivityTracker()
            } else {
                base.removeActivityTracker()
            }
        }
    }
}
