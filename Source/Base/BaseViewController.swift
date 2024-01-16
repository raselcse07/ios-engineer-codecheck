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
    
    
    func showToast(message: String, duration: TimeInterval = 2.0) {
        
        let toastView = ToastView(message: message)
        view.addSubview(toastView)
        
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            UIView.animate(withDuration: 0.3, animations: {
                toastView.alpha = 0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        }
    }
    
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
    
    var isBusy: Binder<Bool> {
        Binder(base) { base, busy in
            if busy {
                base.displayActivityTracker()
            } else {
                base.removeActivityTracker()
            }
        }
    }
    
    var showToast: Binder<String> {
        Binder(base) { base, message in
            base.showToast(message: message)
        }
    }
}
