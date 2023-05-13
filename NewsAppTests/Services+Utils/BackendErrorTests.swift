//
//  BackendErrorTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class BackendErrorTests: XCTestCase {

    func testUnauthorized() {
        let unauthorizedError = BackendError.unauthorized
        XCTAssertEqual(unauthorizedError.statusCode, 401)
        XCTAssertEqual(unauthorizedError.message, "Unauthorized")
        XCTAssertEqual(unauthorizedError.reason, .generic)
    }

    func testServerError() {
        let code = 500
        let serverError = BackendError.serverError(withCode: code)
        XCTAssertEqual(serverError.statusCode, code)
        XCTAssertEqual(serverError.message, "Server Error \(code)")
        XCTAssertEqual(serverError.reason, .serverError)
    }

    func testRequestTimedOut() {
        let requestTimedOutError = BackendError.requestTimedOut
        XCTAssertEqual(requestTimedOutError.statusCode, -1001)
        XCTAssertEqual(requestTimedOutError.message, "The request timed out")
        XCTAssertEqual(requestTimedOutError.reason, .requestTimeOut)
    }
}
