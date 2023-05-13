//
//  UITableViewCell+Extension.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit


extension UITableViewCell: Reusable {
    public static var identifierCell: String { return String(describing: self)}
}
