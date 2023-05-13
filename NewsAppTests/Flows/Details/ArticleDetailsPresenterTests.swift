//
//  ArticleDetailsPresenterTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class ArticleDetailsPresenterTests: XCTestCase {
    
    func testInit() {
        // Given
        let viewController = ArticleDetailsDisplayLogicMock()
        
        // When
        let presenter = ArticleDetailsPresenter(viewController: viewController)
        
        // Then
        XCTAssertNotNil(presenter.viewController)
    }
}
