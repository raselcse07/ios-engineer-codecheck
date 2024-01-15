//
//  AppCoordinator.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> UIViewController {
        let repoCoordinator = RepositoryCoordinator(navigationController: navigationController)
        navigationController.setViewControllers([repoCoordinator.start()], animated: true)
        return navigationController
    }
}
