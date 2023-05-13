//
//  APIError.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol APIError: Error {
    var statusCode: Int { get }
    var message: String { get }
    var reason: Reason { get }
}
