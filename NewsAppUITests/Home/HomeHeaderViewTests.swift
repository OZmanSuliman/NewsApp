//
//  HomeHeaderViewTests.swift
//  NewsAppUITests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest

class HomeHeaderViewTests: XCTestCase {
    
    func test_homeHeaderView() {
        let app = XCUIApplication()
        app.launch()

        // Find the home header view and its subviews
        let homeHeaderView = app.otherElements["homeHeaderView"]
        let coverImage = homeHeaderView.images["coverImage"]
        let titleLabel = homeHeaderView.staticTexts["titleLabel"]

        // Verify the cover image and title label are displayed correctly
        XCTAssertTrue(homeHeaderView.exists)
        XCTAssertTrue(coverImage.exists)
        XCTAssertTrue(titleLabel.exists)
        XCTAssertEqual(titleLabel.label, "News App")
    }
}

