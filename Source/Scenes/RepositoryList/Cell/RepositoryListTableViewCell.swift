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
    
    func setup(with item: Item) {
        titleLabel.text = item.title
    }
}

// MARK: - RepositoryListTableViewCell.Item
extension RepositoryListTableViewCell {
    
    struct Item {
        let id: Int
        let title: String
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

