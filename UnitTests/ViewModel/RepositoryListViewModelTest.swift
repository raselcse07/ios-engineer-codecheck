//
//  RepositoryListViewModelTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

import XCTest
import RxSwift
import RxCocoa
import RxTest

class RepositoryListViewModelTest: TestCase {
    
    // MARK: - Utility
    private func createViewModelSchedulerAndAPIClient() 
    -> (scheduler: TestScheduler, viewModel: RepositoryListViewModel, apiClient: MockClient) {
        let scheduler   = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
        let apiClient   = MockClient()
        let viewModel   = RepositoryListViewModel(apiClient: apiClient)
        return (scheduler, viewModel, apiClient)
    }
    
    // MARK: Tests
    func testSections() throws {
        
        // scheduler, viewModel, apiClient
        let (scheduler, viewModel, apiClient) = createViewModelSchedulerAndAPIClient()
        
        // register some data
        let successTask = try success(result: TestData.githubModel)
        let param = GitRepositoryRequestParameter(query: "Swift")
        let request = GitRepositoryRequest(parameter: param)
        apiClient.register(for: request, with: successTask)
        
        // observable
        let searchTextObservable = scheduler.createColdObservable([
            .next(10, "Swift")
        ])
        
        // observer
        let sectionObserver = scheduler.createObserver([GithubRepositoryListSection].self)
        
        // input
        searchTextObservable
            .bind(to: viewModel.input.searchText)
            .disposed(by: rx.disposeBag)
        
        // output
        viewModel.output
            .sections
            .drive(sectionObserver)
            .disposed(by: rx.disposeBag)
        
        scheduler.start()
        
        // check
        let items = sectionObserver.events.first!.value.element!.first!.items
        // total items : 2
        XCTAssertTrue(items.count == 2)
        // first item fullName: "Apple/Swift"
        XCTAssertEqual(items.first!.fullName, "Apple/Swift")
        // first item stargazersCount: 1000
        XCTAssertEqual(items.first!.stargazersCount, 1000)
        // first item language: "C++"
        XCTAssertEqual(items.first!.language, "C++")
        // second item fullName: "Apple/SwiftUI"
        XCTAssertEqual(items.last!.fullName, "Apple/SwiftUI")
        // second item stargazersCount: 200
        XCTAssertEqual(items.last!.stargazersCount, 200)
        // second item language: "Swift"
        XCTAssertEqual(items.last!.language, "Swift")
    }
    
    func testDetailRequest() throws {
        
        // scheduler, viewModel
        let (scheduler, viewModel, _) = createViewModelSchedulerAndAPIClient()
        
        let modelSelectedObservable = scheduler.createHotObservable([
            .next(20, TestData.githubModel.items.first!)
        ])
        
        // observer
        let selectedModelObserver = scheduler.createObserver(GithubItem.self)
        
        // input
        modelSelectedObservable
            .bind(to: viewModel.input.selectedModel)
            .disposed(by: rx.disposeBag)
        
        // output
        viewModel.output
            .detailRequest
            .drive(selectedModelObserver)
            .disposed(by: rx.disposeBag)
        
        scheduler.start()
        
        // check
        let model = selectedModelObserver.events.first!.value.element!
        XCTAssertOfType(model, GithubItem.self)
    }
}
