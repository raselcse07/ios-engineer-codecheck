//
//  RepositoryDetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import RxSwift
import RxCocoa
import NSObject_Rx

final class RepositoryDetailViewModel: BaseViewModel,
                                       ViewModelProtocol {
    
    // MARK: - Properties
    var input: Input!
    var output: Output!
    
    private let item: GithubItem
    
    // MARK: - Input Processing Subjects
    private let viewDidAppearSubject = PublishSubject<Void>()
    
    // MARK: - Output Processing Subjects
    let avatarImageURLSubject = PublishSubject<String>()
    let titleSubject = PublishSubject<String>()
    let watchersCountSubject = PublishSubject<String>()
    let starCountSubject = PublishSubject<String>()
    let forkCountSubject = PublishSubject<String>()
    let issueCountSubject = PublishSubject<String>()
    let languageSubject = PublishSubject<String>()
    
    // MARK: - Initialization
    init(item: GithubItem) {
        self.item = item
        super.init()
        makeInputOutput()
        bind()
    }
}

// MARK: - Input/Output
extension RepositoryDetailViewModel {
    
    struct Input {
        let viewDidAppear: AnyObserver<Void>
    }
    
    struct Output {
        let avatarImageURL: Driver<String>
        let title: Driver<String>
        let watchersCount: Driver<String>
        let starCount: Driver<String>
        let forkCount: Driver<String>
        let issueCount: Driver<String>
        let language: Driver<String>
    }
    
    private func makeInputOutput() {
        
        input = Input(
            viewDidAppear: viewDidAppearSubject.asObserver()
        )
        
        output = Output(
            avatarImageURL: avatarImageURLSubject.asDriver(onErrorJustReturn: ""),
            title: titleSubject.asDriver(onErrorJustReturn: ""),
            watchersCount: watchersCountSubject.asDriver(onErrorJustReturn: ""),
            starCount: starCountSubject.asDriver(onErrorJustReturn: ""),
            forkCount: forkCountSubject.asDriver(onErrorJustReturn: ""),
            issueCount: issueCountSubject.asDriver(onErrorJustReturn: ""),
            language: languageSubject.asDriver(onErrorJustReturn: "")
        )
    }
}

// MARK: - Bind
extension RepositoryDetailViewModel {
    
    func bind() {
        
        let item = viewDidAppearSubject
            .map { [unowned self] _ in self.item }
            .share(replay: 1)
        
        // avatar url
        item
            .map { $0.owner.avatarURL }
            .bind(to: avatarImageURLSubject)
            .disposed(by: rx.disposeBag)
        
        // title
        item
            .map { $0.fullName }
            .bind(to: titleSubject)
            .disposed(by: rx.disposeBag)
        
        // watchers count
        item
            .map { "\($0.watchersCount.toString()) \(Constant.Text.watchers)" }
            .bind(to: watchersCountSubject)
            .disposed(by: rx.disposeBag)
        
        // start count
        item
            .map { "\($0.stargazersCount.toString()) \(Constant.Text.stars)" }
            .bind(to: starCountSubject)
            .disposed(by: rx.disposeBag)
        
        // fork count
        item
            .map { "\($0.forksCount.toString()) \(Constant.Text.forks)" }
            .bind(to: forkCountSubject)
            .disposed(by: rx.disposeBag)
        
        // issues count
        item
            .map { "\($0.openIssuesCount.toString()) \(Constant.Text.issues)" }
            .bind(to: issueCountSubject)
            .disposed(by: rx.disposeBag)
        
        // written language
        item
            .map {
                guard let language = $0.language else {
                    return Constant.Text.unknown
                }
                return "\(Constant.Text.writtenIn) \(language)"
            }
            .bind(to: languageSubject)
            .disposed(by: rx.disposeBag)
        
    }
}
