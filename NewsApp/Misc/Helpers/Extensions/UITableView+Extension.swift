//
//  UITableView+Extension.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit
extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifierCell)
    }
    
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.identifierCell, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.identifierCell)
    }
}
