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
import RxDataSources

class RepositoryListViewController: BaseViewController,
                                    ViewModelable,
                                    Coordinatable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(RepositoryListTableViewCell.self)
            tableView.keyboardDismissMode = .interactive
            tableView.keyboardDismissMode = .onDrag
        }
    }
    
    // MARK: - Properties
    var viewModel: RepositoryListViewModel!
    var coordinator: RepositoryCoordinator?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = Constant.Text.repoSearchPlaceHolder
        return searchController
    }()
    
    private var dataSource: RxTableViewSectionedAnimatedDataSource<GithubRepositoryListSection>?
    
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
        
        // Data Source
        makeDataSource()
        guard let dataSource = dataSource else {
            return
        }
        
        // input
        searchController.searchBar
            .rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { $0.count >= 2 }
            .bind(to: viewModel.input.searchText)
            .disposed(by: rx.disposeBag)
        
        // output
        viewModel.output
            .sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .isBusy
            .drive(rx.isBusy)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Data Source
extension RepositoryListViewController {
    private func makeDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource(configureCell: {_, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(with: RepositoryListTableViewCell.self, for: indexPath)
            cell.setup(with: item)
            return cell
        })
    }
}

// MARK: - Utils
extension RepositoryListViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = Constant.Text.repoSearchNavigationItemTitle
        navigationItem.searchController = searchController
    }
}
