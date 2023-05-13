//
//  HomePresenterTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class HomePresenterTests: XCTestCase {
    
    var mockViewController: MockHomeDisplayLogic!
    var homePresenter: HomePresenter!

    override func setUp() {
        super.setUp()
        mockViewController = MockHomeDisplayLogic()
        homePresenter = HomePresenter(viewController: mockViewController)
    }

    override func tearDown() {
        mockViewController = nil
        homePresenter = nil
        super.tearDown()
    }

    func testUpdateArticlesList() {
        let mockArticles = [Article(uri: nil, url: nil, id: 1, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil)]
        homePresenter.updateArticlesList(mockArticles)
        XCTAssertTrue(mockViewController.displayArticlesCalled, "Display articles should be called")
        XCTAssertEqual(mockArticles.count, mockViewController.displayedArticles?.count, "Number of displayed articles should be equal to number of articles")
    }
    
    
    func testShowError() {
        let mockError = NSError(domain: "Test", code: 0, userInfo: nil)
  
        homePresenter.updateArticlesList([])
        homePresenter.showError(error: mockError)
        XCTAssertTrue(mockViewController.showErrorCalled, "Show error should be called if articles are empty")
        XCTAssertEqual(mockError.localizedDescription, mockViewController.displayedError, "Displayed error should be equal to error.localizedDescription")
    }
    
    func testShowLoader() {
        homePresenter.showLoader()
        XCTAssertTrue(mockViewController.showLoaderCalled, "Show loader should be called")
    }
}
