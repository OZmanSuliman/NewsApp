//
//  MockHomeDisplayLogic.swift
//  NewsApp
//
//  Created by Osman Ahmed on 13/05/2023.
//

import Foundation

class MockHomeDisplayLogic: HomeDisplayLogic {
    
    var displayArticlesCalled = false
    var displayedArticles: [Article]?
    func displayArticles(_ articles: [Article]) {
        displayArticlesCalled = true
        displayedArticles = articles
    }
    
    var showErrorCalled = false
    var displayedError: String?
    func showError(error: String) {
        showErrorCalled = true
        displayedError = error
    }
    
    var showLoaderCalled = false
    func showLoader() {
        showLoaderCalled = true
    }
    
    func reset() {
        displayArticlesCalled = false
        displayedArticles = nil
        showErrorCalled = false
        displayedError = nil
        showLoaderCalled = false
    }
}
