//
//  ArticleDetailsInteractorTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class ArticleDetailsInteractorTests: XCTestCase {
    
    var interactor: ArticleDetailsInteractor!
    var presenterMock: ArticleDetailsPresenter!
    
    override func setUp() {
        super.setUp()
        presenterMock = ArticleDetailsPresenter(viewController: ArticleDetailsDisplayLogicMock())
        interactor = ArticleDetailsInteractor(presenter: presenterMock)
    }
    
    override func tearDown() {
        presenterMock = nil
        interactor = nil
        super.tearDown()
    }
    
    func testInteractorInitialization() {
        XCTAssertNotNil(interactor.presenter)
    }
}

