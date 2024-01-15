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
                               ViewModelProtocol {
    
    // MARK: - Properties
    var input: Input!
    var output: Output!
    
    
    // MARK: - Input Processing Subjects
    private let searchTextSubject = PublishSubject<String>()
    
    // MARK: - Output Processing Subjects
    
    // MARK: - Initializes
    override init() {
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
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: rx.disposeBag)
    }
}

