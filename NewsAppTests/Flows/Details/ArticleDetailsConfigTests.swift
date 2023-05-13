//
//  ArticleDetailsConfigTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class ArticleDetailsConfigTests: XCTestCase {
    
    func testCreateViewController() {
        // Given
        let article =  Article(uri: nil, url: nil, id: 1, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil)
        let config = ArticleDetailsConfig()
        
        // When
        let viewController = config.createViewController(article: article)
        
        // Then
        XCTAssertTrue(viewController is ArticleDetailsViewController)
        XCTAssertNotNil((viewController as? ArticleDetailsViewController)?.interactor)
        XCTAssertNotNil((viewController as? ArticleDetailsViewController)?.router)
        XCTAssertEqual((viewController as? ArticleDetailsViewController)?.article, article)
    }
}

