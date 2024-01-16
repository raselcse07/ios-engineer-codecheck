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
    private let selectedModelSubject = PublishSubject<GithubItem>()
    private let cancelButtonClickedSubject = PublishSubject<Void>()
    
    // MARK: - Output Processing Subjects
    private let sectionSubject = PublishSubject<[GithubRepositoryListSection]>()
    private let detailRequestSubject = PublishSubject<GithubItem>()
    
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
        let selectedModel: AnyObserver<GithubItem>
        let didClickedOnCancelButton: AnyObserver<Void>
    }
    
    struct Output {
        let sections: Driver<[GithubRepositoryListSection]>
        let detailRequest: Driver<GithubItem>
        let isBusy: Driver<Bool>
        let message: Driver<String>
    }
    
    private func makeInputOutput() {
        
        input = Input(
            searchText: searchTextSubject.asObserver(), 
            selectedModel: selectedModelSubject.asObserver(), 
            didClickedOnCancelButton: cancelButtonClickedSubject.asObserver()
        )
        
        output = Output(
            sections: sectionSubject.asDriverOnErrorJustComplete(), 
            detailRequest: detailRequestSubject.asDriverOnErrorJustComplete(),
            isBusy: activityIndicator.asDriver(),
            message: messageSinkRelay.compactMap { $0 }.asDriver(onErrorJustReturn: "")
        )
    }
}

// MARK: - Bind
extension RepositoryListViewModel {
    
    func bind() {
        
        searchTextSubject
            .flatMapLatest { [unowned self] in self.fetchRepository(with: $0) }
            .map { [GithubRepositoryListSection(items: $0.items)] }
            .bind(to: sectionSubject)
            .disposed(by: rx.disposeBag)
        
        selectedModelSubject
            .bind(to: detailRequestSubject)
            .disposed(by: rx.disposeBag)
        
        cancelButtonClickedSubject
            .map { _ -> [GithubRepositoryListSection] in [] }
            .bind(to: sectionSubject)
            .disposed(by: rx.disposeBag)
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
    
    var items: [GithubItem]
    
    var identity: String {
        "GithubRepositoryListSection"
    }
}

// MARK: - GithubRepositoryListSection + AnimatableSectionModelType
extension GithubRepositoryListSection: AnimatableSectionModelType {
    
    init(original: GithubRepositoryListSection, items: [GithubItem]) {
        self = original
        self.items = items
    }
}
