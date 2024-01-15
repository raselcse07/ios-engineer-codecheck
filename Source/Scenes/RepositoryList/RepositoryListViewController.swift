//
//  RepositoryListViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryListViewController: BaseViewController,
                                    ViewModelable,
                                    Coordinatable {
    
    // MARK: - Properties
    var viewModel: RepositoryListViewModel!
    var coordinator: RepositoryCoordinator?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
