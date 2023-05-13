//
//  ServicesFactoryTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class ServicesFactoryTests: XCTestCase {

    func testMakeArticlesNetworkService() {
        let articlesNetworkService = ServicesFactory.shared.makeArticlesNetworkService()
        XCTAssertTrue(articlesNetworkService is ArticlesNetworkService)
    }
    
    func testMakeKeychainService() {
        let keychainService = ServicesFactory.shared.makeKeychainService()
        XCTAssertTrue(keychainService is KeychainService)
    }
    
    func testMakeDatabaseService() {
        let databaseService = ServicesFactory.shared.makeDatabaseService()
        XCTAssertTrue(databaseService is DatabaseService)
    }
}
