//
//  RepositoryListViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class RepositoryListViewController: BaseViewController,
                                    ViewModelable,
                                    Coordinatable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: RepositoryListViewModel!
    var coordinator: RepositoryCoordinator?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = Constant.Text.repoSearchPlaceHolder
        return searchController
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupObserver()
    }
}

// MARK: - Binding
extension RepositoryListViewController {
    
    private func setupObserver() {
        
        // input
        searchController.searchBar
            .rx.text.orEmpty
            .filter { !$0.isEmpty }
            .bind(to: viewModel.input.searchText)
            .disposed(by: rx.disposeBag)
        
    }
}

// MARK: - Utils
extension RepositoryListViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = Constant.Text.repoSearchNavigationItemTitle
        navigationItem.searchController = searchController
    }
}
