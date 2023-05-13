//
//  APIRequestProtocolTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class APIRequestProtocolTests: XCTestCase {
    struct MockRequest: APIRequestProtocol {
        var endpoint: String = "mockEndpoint"
    }
    
    func testDefaultValues() {
        let request = MockRequest()
        XCTAssertEqual(request.method, .get)
        XCTAssertNotNil(request.parameters)
        XCTAssertNotNil(request.arrayParameters)
        XCTAssertEqual(request.headers, [:])
        XCTAssertNil(request.formData)
        XCTAssertNotNil(request.formDataParameters)
        XCTAssertEqual(request.isFormURLEncoded, false)
        XCTAssertEqual(request.apiTokenType, .accessToken)
    }
}
