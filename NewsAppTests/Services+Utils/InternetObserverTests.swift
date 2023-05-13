//
//  InternetObserverTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
import Reachability
@testable import NewsApp_Dev

class InternetObserverTests: XCTestCase {

    var internetObserver: InternetObserver!

    override func setUp() {
        super.setUp()
        internetObserver = InternetObserver.shared
    }

    override func tearDown() {
        internetObserver = nil
        super.tearDown()
    }

    func testStartNetworkListener() {
        internetObserver.startNetworkListener()
        XCTAssertTrue(internetObserver.isOnline)
    }

    func testIsOnline() {
        internetObserver.startNetworkListener()
        XCTAssertTrue(internetObserver.isOnline)
    }
}
