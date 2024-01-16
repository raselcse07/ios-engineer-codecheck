//
//  RepositoryListTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit

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
    
    func setup(with item: GithubItem) {
        titleLabel.attributedText = item.fullName.attributed(font: .regularCaption, color: .black)
        avatarImageView.setImage(urlString: item.owner.avatarURL)
        watchCountView.setup(
            with: UIImage(systemName: Constant.SystemImageName.eye)!,
            attributedString: item.watchersCount.toString()
                .attributed(font: .smallCaption, color: .gray)
        )
        starCountView.setup(
            with: UIImage(systemName: Constant.SystemImageName.start)!,
            attributedString: item.stargazersCount.toString()
                .attributed(font: .smallCaption, color: .gray)
        )
        languageView.setup(
            with: UIImage(systemName: Constant.SystemImageName.pencilLine)!,
            attributedString: (item.language ?? Constant.Text.unknown)
                .attributed(font: .smallCaption, color: .gray)
        )
    }
}
