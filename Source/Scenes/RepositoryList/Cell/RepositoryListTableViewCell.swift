//
//  RepositoryListTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxDataSources

class RepositoryListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var avatarImageView: RoundImageView!
    @IBOutlet private weak var watchCountView: ImageWithTextView!
    @IBOutlet private weak var starCountView: ImageWithTextView!
    @IBOutlet private weak var languageView: ImageWithTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    func setup(with item: Item) {
        titleLabel.attributedText = item.title.attributed(font: .regulaCcaption, color: .black)
        avatarImageView.setImage(urlString: item.avatarURLString)
        watchCountView.setup(
            with: UIImage(systemName: Constant.SystemImageName.eye)!,
            attributedString: item.watchCount.toString().attributed(font: .smallCaption, color: .gray)
        )
        starCountView.setup(
            with: UIImage(systemName: Constant.SystemImageName.start)!,
            attributedString: item.startCount.toString().attributed(font: .smallCaption, color: .gray)
        )
        languageView.setup(
            with: UIImage(systemName: Constant.SystemImageName.pencilLine)!,
            attributedString: item.language.attributed(font: .smallCaption, color: .gray)
        )
    }
}

// MARK: - RepositoryListTableViewCell.Item
extension RepositoryListTableViewCell {
    
    struct Item {
        let id: Int
        let title: String
        let avatarURLString: String
        let watchCount: Int
        let startCount: Int
        let language: String
    }
}

// MARK: - RepositoryListTableViewCell.Item + Equatable
extension RepositoryListTableViewCell.Item: Equatable {
    
    static func == (lhs: RepositoryListTableViewCell.Item, rhs: RepositoryListTableViewCell.Item) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title
    }
}

// MARK: - RepositoryListTableViewCell.Item + IdentifiableType
extension RepositoryListTableViewCell.Item: IdentifiableType {
    
    var identity: Int {
        id
    }
}

