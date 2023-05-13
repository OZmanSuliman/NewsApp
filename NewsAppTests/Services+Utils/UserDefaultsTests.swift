//
//  UserDefaultsTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class UserDefaultsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "lastUpdatedApiTokenTimeInfo")
        UserDefaults.standard.removeObject(forKey: "hasApiAccessTokenInfo")
        UserDefaults.standard.removeObject(forKey: "test")
        UserDefaults.standard.removeObject(forKey: "testCodable")
    }
    
    func testUserDefaultInfo() {
        let expectation1 = XCTestExpectation(description: "Persist article after 1 second")
        let expectation2 = XCTestExpectation(description: "Persist article after 1 second")
        let userDefaultInfo = UserDefaultInfo<Int>(key: "test", defaultValue: 10)
        let value = userDefaultInfo.get()
        XCTAssertEqual(value, 10)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation1.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation1], timeout: 2.0)
        userDefaultInfo.set(20)
        let updatedValue = userDefaultInfo.get()
        XCTAssertEqual(updatedValue, 20)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation2.fulfill()
        }
        // Wait for the expectation to be fulfilled
        wait(for: [expectation2], timeout: 2.0)
        let codableUserDefaultInfo = UserDefaultInfo(key: "testCodable", defaultValue: TestCodable(name: "test", age: 20))
        codableUserDefaultInfo.setObject(encodable: TestCodable(name: "newTest", age: 30))
        let object: TestCodable? = codableUserDefaultInfo.getObject()
        XCTAssertEqual(object?.name, "newTest")
        XCTAssertEqual(object?.age, 30)
    }
    
    func testUserDefaultsEnum() {
        let lastUpdatedApiTokenTime = UserDefaultsEnum.lastUpdatedApiTokenTime
        XCTAssertNotNil(lastUpdatedApiTokenTime)
        
        let hasApiAccessToken = UserDefaultsEnum.hasApiAccessToken
        XCTAssertFalse(hasApiAccessToken)
        
        UserDefaultsEnum.hasApiAccessToken = true
        XCTAssertTrue(UserDefaultsEnum.hasApiAccessToken)
    }

}

struct TestCodable: Codable {
    let name: String
    let age: Int
}

