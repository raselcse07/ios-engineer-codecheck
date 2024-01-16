//
//  RepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/16.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class RepositoryDetailViewController: BaseViewController,
                                      ViewModelable {

    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var starCountLabel: UILabel!
    @IBOutlet private weak var forkCountLabel: UILabel!
    @IBOutlet private weak var issueCountLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: RepositoryDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
    }
}

// MARK: - Setup Observer
extension RepositoryDetailViewController {
    
    private func setupObserver() {
        
        // input
        rx.viewDidAppear
            .bind(to: viewModel.input.viewDidAppear)
            .disposed(by: rx.disposeBag)
        
        // output
        viewModel.output
            .avatarImageURL
            .drive(avatarImageView.rx.setImage)
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .title
            .map { $0.attributed(font: .largeBoldCaption, color: .black) }
            .drive(titleLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .watchersCount
            .map { $0.attributed(font: .mediumCaption, color: .black) }
            .drive(watchersLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .starCount
            .map { $0.attributed(font: .mediumCaption, color: .black) }
            .drive(starCountLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .forkCount
            .map { $0.attributed(font: .mediumCaption, color: .black) }
            .drive(forkCountLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .issueCount
            .map { $0.attributed(font: .mediumCaption, color: .black) }
            .drive(issueCountLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .language
            .map { $0.attributed(font: .boldCaption, color: .black) }
            .drive(languageLabel.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
    }
}
