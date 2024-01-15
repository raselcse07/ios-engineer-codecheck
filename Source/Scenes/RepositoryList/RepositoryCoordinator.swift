//
//  RepositoryCoordinator.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @discardableResult
    func start() -> UIViewController {
        var repoController: RepositoryListViewController = .instantiateViewController()
        let viewModel = RepositoryListViewModel()
        repoController.bind(to: viewModel)
        repoController.register(to: self)
        return repoController
    }
}
