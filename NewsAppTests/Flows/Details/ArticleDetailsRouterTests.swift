//
//  ArticleDetailsRouterTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class ArticleDetailsRouterTests: XCTestCase {
    
    func testRouter() {
        // Given
        let viewController = ArticleDetailsViewController.initFromNib()
        let router = ArticleDetailsRouter(viewController: viewController)
        
        // Then
        XCTAssertTrue(router.viewController === viewController)
    }
}

