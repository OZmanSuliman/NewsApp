//
//  APITokenTypeTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class APITokenTypeTests: XCTestCase {
    func testNone() {
        let apiTokenType = APITokenType.none
        XCTAssertNotNil(apiTokenType)
    }
    
    func testAccessToken() {
        let apiTokenType = APITokenType.accessToken
        XCTAssertNotNil(apiTokenType)
    }
    
    func testRefreshToken() {
        let apiTokenType = APITokenType.refreshToken
        XCTAssertNotNil(apiTokenType)
    }
}
