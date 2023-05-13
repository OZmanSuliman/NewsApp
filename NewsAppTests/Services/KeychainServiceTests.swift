//
//  KeychainServiceTests.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import XCTest
@testable import NewsApp_Dev

class KeychainServiceTests: XCTestCase {
    
    var keychainService: KeychainService!
    
    override func setUp() {
        super.setUp()
        keychainService = KeychainService()
    }
    
    override func tearDown() {
        keychainService.removeAuthState()
        keychainService = nil
        super.tearDown()
    }
    
    func testSaveAndFetchAccessToken() {
        let accessToken = "testAccessToken"
        
        keychainService.saveAccessToken(accessToken)
        let fetchedAccessToken = keychainService.fetchAccessToken()
        
        XCTAssertEqual(fetchedAccessToken, accessToken)
    }
    
    func testSaveAndFetchRefreshToken() {
        let refreshToken = "testRefreshToken"
        
        keychainService.saveRefreshToken(refreshToken)
        let fetchedRefreshToken = keychainService.fetchRefreshToken()
        
        XCTAssertEqual(fetchedRefreshToken, refreshToken)
    }
    
    func testSaveAndFetchExpiresTokenTime() {
        let expiresTokenTime = 123456
            
        keychainService.saveExpiresTokenTime(expiresTokenTime)
        let fetchedExpiresTokenTime = keychainService.fetchExpiresTokenTime()
        
        XCTAssertEqual(fetchedExpiresTokenTime, expiresTokenTime)
    }
    
    func testRemoveAuthState() {
        keychainService.saveAccessToken("testAccessToken")
        keychainService.saveRefreshToken("testRefreshToken")
        keychainService.saveExpiresTokenTime(123456)
        
        keychainService.removeAuthState()
        
        XCTAssertNil(keychainService.fetchAccessToken())
        XCTAssertNil(keychainService.fetchRefreshToken())
        XCTAssertNil(keychainService.fetchExpiresTokenTime())
    }
}

