//
//  RepositoryListViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources

class RepositoryListViewModel: BaseViewModel,
                               ViewModelProtocol,
                               APICommunicatingViewModel {
    
    // MARK: - Properties
    var input: Input!
    var output: Output!
    var apiClient: APIClientProtocol
    
    // MARK: - Input Processing Subjects
    private let searchTextSubject = PublishSubject<String>()
    
    // MARK: - Output Processing Subjects
    private let sectionSubject = PublishSubject<[GithubRepositoryListSection]>()
    
    // MARK: - Initialization
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
        super.init()
        makeInputOutput()
        bind()
    }
    
}

// MARK: - Input/Output
extension RepositoryListViewModel {
    
    struct Input {
        let searchText: AnyObserver<String>
    }
    
    struct Output {
        let sections: Driver<[GithubRepositoryListSection]>
        let isBusy: Driver<Bool>
    }
    
    private func makeInputOutput() {
        
        input = Input(
            searchText: searchTextSubject.asObserver()
        )
        
        output = Output(
            sections: sectionSubject.asDriverOnErrorJustComplete(),
            isBusy: activityIndicator.asDriver()
        )
    }
}

// MARK: - Bind
extension RepositoryListViewModel {
    
    func bind() {
        
        searchTextSubject.asObservable()
            .flatMapLatest { [unowned self] in self.fetchRepository(with: $0) }
            .map { $0.items.map { [unowned self] in self.composeSections(using: $0) }}
            .map { [GithubRepositoryListSection(items: $0)] }
            .bind(to: sectionSubject)
            .disposed(by: rx.disposeBag)
    }
}

// MARK: - Compose Section
extension RepositoryListViewModel {
    private func composeSections(using item: GithubItem) -> RepositoryListTableViewCell.Item {
        RepositoryListTableViewCell.Item(
            id: item.id,
            title: item.fullName,
            avatarURLString: item.owner.avatarURL,
            watchCount: item.watchersCount,
            startCount: item.stargazersCount, 
            language: item.language ?? Constant.Text.unknown
        )
    }
}

// MARK: - API Communication
extension RepositoryListViewModel {
    
    private func fetchRepository(with query: String) -> Observable<GithubModel> {
        let parameter = GitRepositoryRequestParameter(query: query)
        let request = GitRepositoryRequest(parameter: parameter)
        return doAPIRequest(request)
    }
}

// MARK: - Section Model
struct GithubRepositoryListSection: IdentifiableType {
    
    var items: [RepositoryListTableViewCell.Item]
    
    var identity: String {
        "GithubRepositoryListSection"
    }
}

// MARK: - GithubRepositoryListSection + AnimatableSectionModelType
extension GithubRepositoryListSection: AnimatableSectionModelType {
    
    init(original: GithubRepositoryListSection, items: [RepositoryListTableViewCell.Item]) {
        self = original
        self.items = items
    }
}
