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
    
    // MARK: - Initializes
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
        
    }
    
    private func makeInputOutput() {
        
        input = Input(searchText: searchTextSubject.asObserver())
        
        output = Output()
    }
}

// MARK: - Bind
extension RepositoryListViewModel {
    
    func bind() {
        
        searchTextSubject.asObservable()
            .flatMapLatest { [unowned self] in self.fetchRepository(with: $0) }
            .subscribe(onNext: {
                print($0)
            })
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
