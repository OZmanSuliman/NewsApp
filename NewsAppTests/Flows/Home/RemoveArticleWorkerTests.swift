//
//  RemoveArticleWorkerTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
import RealmSwift
@testable import NewsApp_Dev

class RemoveArticleWorkerTests: XCTestCase {

    var worker: RemoveArticleWorker!
    var database: MockDatabaseService!

    override func setUp() {
        super.setUp()
        database = MockDatabaseService()
        worker = RemoveArticleWorker(dataBaseManager: database)
        let persistensWorker = PersistArticleWorker(dataBaseManager: database)
        let articles: [Article] = [
            Article(uri: nil, url: nil, id: 1, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil),
            Article(uri: nil, url: nil, id: 2, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil),
            Article(uri: nil, url: nil, id: 3, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil)
        ]
        persistensWorker.persistArticle(articles)
    }

    override func tearDown() {
        worker = nil
        database = nil
        super.tearDown()
    }

    func testRemoveArticle() {
        // Create an XCTestExpectation with a 1 second timeout
         let expectation = XCTestExpectation(description: "remove article after 1 second")
        let expectationToMakeSureArTiclesAdded = XCTestExpectation(description: "remove article after 1 second")
        let article = Article(uri: nil, url: nil, id: 1, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil)
        // Wait for 1 second before fulfilling the expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectationToMakeSureArTiclesAdded.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectationToMakeSureArTiclesAdded], timeout: 2.0)
        worker.removeArticle(article)
        // Wait for 1 second before fulfilling the expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)
        // Ensure that the object was deleted from the mock database service
        XCTAssertEqual(database.deletedModels.count, 1)
        XCTAssertEqual(database.deletedModels.first as? Article, article)
    }

    func testRemoveArticles() {
        // Create an XCTestExpectation with a 1 second timeout
         let expectation = XCTestExpectation(description: "remove article after 1 second")
        let expectationToMakeSureArTiclesAdded = XCTestExpectation(description: "remove article after 1 second")
        let articles = [
            Article(uri: nil, url: nil, id: 2, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil),
            Article(uri: nil, url: nil, id: 3, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil)
        ]
        // Wait for 1 second before fulfilling the expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectationToMakeSureArTiclesAdded.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectationToMakeSureArTiclesAdded], timeout: 2.0)
        worker.removeArticles(articles)
        // Wait for 1 second before fulfilling the expectation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)
        // Ensure that the objects were cleared from the mock database service
        XCTAssertTrue(database.models.isEmpty)
    }

}

