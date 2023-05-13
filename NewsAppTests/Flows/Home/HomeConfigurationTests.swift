//
//  HomeConfigurationTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class HomeConfigurationTests: XCTestCase {

    func test_createViewController() {
        // given
        let config = HomeConfiguration()

        // when
        let vc = config.createViewController()

        // then
        XCTAssertTrue(vc is HomeViewController)
        XCTAssertNotNil((vc as? HomeViewController)?.interactor)
        XCTAssertNotNil((vc as? HomeViewController)?.router)
    }
}
