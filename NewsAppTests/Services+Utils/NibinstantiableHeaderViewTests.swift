//
//  NibinstantiableHeaderViewTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class MockTableViewHeaderFooterView: UITableViewHeaderFooterView, NibinstantiableHeaderView {
    static var nibName: String {
        return "MockTableViewHeaderFooterView"
    }
}

class NibinstantiableHeaderViewTests: XCTestCase {

    func testNibName() {
        XCTAssertEqual(MockTableViewHeaderFooterView.nibName, "MockTableViewHeaderFooterView")
    }

    func testNib() {
        let nib = MockTableViewHeaderFooterView.nib
        XCTAssertNotNil(nib)
    }

}
