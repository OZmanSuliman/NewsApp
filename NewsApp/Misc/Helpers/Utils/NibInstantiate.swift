//
//  NibInstantiate.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

import UIKit

protocol NibinstantiableHeaderView {
    static var nibName: String { get }
}

extension NibinstantiableHeaderView where Self: UITableViewHeaderFooterView {

    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    static var nib: UINib {
        return UINib(nibName: Self.nibName, bundle: nil)
    }

    init(owner: AnyObject? = nil) {
        let views = Self.nib.instantiate(withOwner: owner, options: [:])
        for view in views {
            if let view = view as? Self {
                self = view
                return
            }
        }
        fatalError("Nib for class \(Self.nibName) could not be loaded!")
    }

}
