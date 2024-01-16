//
//  UITableView+Ext.swift
//  iOSEngineerCodeCheck
//
//  Created by Rasel on 2024/01/15.
//  Copyright © 2024 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITableView {
    
    func register<Cell: UITableViewCell>(_ cell: Cell.Type) {
        let identifier = String(describing: cell)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        } else {
            register(cell, forCellReuseIdentifier: identifier)
        }
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(with cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }
}

