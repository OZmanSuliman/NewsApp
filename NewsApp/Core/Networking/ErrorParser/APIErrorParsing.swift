//
//  APIErrorParsing.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol APIErrorParsing {

    func parse(response: HTTPURLResponse, data: Data?) -> APIError?
}

