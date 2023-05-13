//
//  GetPersistedArticlesWorkerTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
import RealmSwift
@testable import NewsApp_Dev

class GetPersistedArticlesWorkerTests: XCTestCase {
    
    var worker: GetPersistedArticlesWorker!
    var mockDatabaseService: MockDatabaseService!
    
    override func setUp() {
        super.setUp()
        mockDatabaseService = MockDatabaseService()
        worker = GetPersistedArticlesWorker(dataBaseManager: mockDatabaseService)
    }
    
    override func tearDown() {
        mockDatabaseService.clearDatabase()
        super.tearDown()
    }
    
    func testGetPersistedArticles() {
        // Given
        let article1 = Article()
        let article2 = Article()
        let article3 = Article()
        mockDatabaseService.models = [article1, article2, article3]
        
        // When
        let persistedArticles = worker.getPersistedArticles()
        
        // Then
        XCTAssertEqual(persistedArticles, [article1, article2, article3])
    }
    
    func testGetPersistedArticlesEmpty() {
        // Given
        mockDatabaseService.models = []
        
        // When
        let persistedArticles = worker.getPersistedArticles()
        
        // Then
        XCTAssertTrue(persistedArticles.isEmpty)
    }
}
