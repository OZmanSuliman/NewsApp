//
//  UILabelTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class UILabelTests: XCTestCase {

    func testSetMargins() {
        // Given
        let label = UILabel()
        let text = "Hello, world!"
        label.text = text

        // When
        label.setMargins()

        // Then
        let paragraphStyle = label.attributedText?.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle
        XCTAssertNotNil(paragraphStyle)
        XCTAssertEqual(paragraphStyle?.firstLineHeadIndent, 10)
        XCTAssertEqual(paragraphStyle?.headIndent, 10)
        XCTAssertEqual(paragraphStyle?.tailIndent, -10)
        XCTAssertEqual(label.attributedText?.string, text)
    }

    func testSetMarginsWithCustomMargin() {
        // Given
        let label = UILabel()
        let text = "Hello, world!"
        label.text = text
        let margin: CGFloat = 20

        // When
        label.setMargins(margin: margin)

        // Then
        let paragraphStyle = label.attributedText?.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle
        XCTAssertNotNil(paragraphStyle)
        XCTAssertEqual(paragraphStyle?.firstLineHeadIndent, margin)
        XCTAssertEqual(paragraphStyle?.headIndent, margin)
        XCTAssertEqual(paragraphStyle?.tailIndent, -margin)
        XCTAssertEqual(label.attributedText?.string, text)
    }

}

