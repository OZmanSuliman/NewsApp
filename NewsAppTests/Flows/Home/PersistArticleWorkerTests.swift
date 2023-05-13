//
//  PersistArticleWorkerTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
import RealmSwift
@testable import NewsApp_Dev

class PersistArticleWorkerTests: XCTestCase {

    var worker: PersistArticleWorker!
    var mockDatabaseService: MockDatabaseService!

    override func setUp() {
        super.setUp()
        mockDatabaseService = MockDatabaseService()
        worker = PersistArticleWorker(dataBaseManager: mockDatabaseService)
    }

    override func tearDown() {
        worker = nil
        mockDatabaseService = nil
        super.tearDown()
    }

    func testPersistArticle() {
        // Arrange
        let articles: [Article] = [
            Article(uri: nil, url: nil, id: 1, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil),
            Article(uri: nil, url: nil, id: 2, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil),
            Article(uri: nil, url: nil, id: 3, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil)
        ]
        // Create an XCTestExpectation with a 1 second timeout
         let expectation = XCTestExpectation(description: "Persist article after 1 second")
         
        // Act
        worker.persistArticle(articles)
        // Wait for 1 second before fulfilling the expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)
        

        // Assert
        let savedArtile1: Article = mockDatabaseService.savedModels[0] as! Article
        let savedArtile2: Article = mockDatabaseService.savedModels[1] as! Article
        let savedArtile3: Article = mockDatabaseService.savedModels[2] as! Article
        XCTAssertEqual(mockDatabaseService.savedModels.count, 3)
        XCTAssertEqual(savedArtile1.id, 1)
        XCTAssertEqual(savedArtile2.id, 2)
        XCTAssertEqual(savedArtile3.id, 3)
    }

}

