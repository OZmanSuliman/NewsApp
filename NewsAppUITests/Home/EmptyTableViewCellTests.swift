//
//  EmptyTableViewCellTests.swift
//  NewsAppUITests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class EmptyTableViewCellTests: XCTestCase {

    var cell: EmptyTableViewCell!

    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: EmptyTableViewCell.self)
        let nib = UINib(nibName: "EmptyTableViewCell", bundle: bundle)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        cell = objects.first as? EmptyTableViewCell
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testSetupView() {
        cell.setupView()
        XCTAssertEqual(cell.titleLabel.text, "No Article To Show")
        XCTAssertEqual(cell.subtitleLabel.text, "No Article To Show")
        XCTAssertTrue(cell.titleLabel.font == UIFont.preferredFont(forTextStyle: .title2))
        XCTAssertTrue(cell.subtitleLabel.font == UIFont.preferredFont(forTextStyle: .caption1))
        XCTAssertTrue(cell.animatedView.subviews.contains(where: { $0 is LottieCustomView }))
    }
}

