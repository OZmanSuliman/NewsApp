//
//  ReusableCell.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

public protocol Reusable {
    static var identifierCell: String {get} // reuse Identifier is also nib name
}
