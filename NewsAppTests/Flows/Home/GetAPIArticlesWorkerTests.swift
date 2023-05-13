//
//  GetAPIArticlesWorkerTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class GetAPIArticlesWorkerTests: XCTestCase {
    // Test the success scenario
    func testGetAPIArticlesSuccess() {
        // Given
        let expectedArticles = [Article(uri: nil, url: nil, id: 1, asset_id: nil, source: nil, published_date: nil, updated: nil, section: nil, subsection: nil, nytdsection: nil, adx_keywords: nil, column: nil, byline: nil, type: nil, title: nil, abstract: nil, eta_id: nil)]
        let response = MostPopularResponse(with: Data())
        response.articles = expectedArticles
        let mockNetworkService = MockArticlesNetworkService(response: response)
        let worker = GetAPIArticlesWorker(network: mockNetworkService)
        let expectation = self.expectation(description: "Completion handler invoked")
        
        // When
        worker.getAPIArticles(period: "1") { (articles, error) in
            // Then
            XCTAssertNil(error)
            XCTAssertEqual(articles, expectedArticles)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // Test the failure scenario
    func testGetAPIArticlesFailure() {
        // Given
        let mockNetworkService = MockArticlesNetworkService()
        let expectedError = BackendError(statusCode: 500, message: "", reason: .serverError)
        mockNetworkService.error = expectedError
        let worker = GetAPIArticlesWorker(network: mockNetworkService)
        let expectation = self.expectation(description: "Completion handler invoked")
        
        // When
        worker.getAPIArticles(period: "1") { (articles, error) in
            // Then
            XCTAssertNil(articles)
            XCTAssertEqual((error as? BackendError)?.statusCode, expectedError.statusCode)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
