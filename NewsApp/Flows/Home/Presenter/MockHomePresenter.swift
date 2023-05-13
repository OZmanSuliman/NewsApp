//
//  MockHomePresenter.swift
//  NewsApp
//
//  Created by Osman Ahmed on 13/05/2023.
//

import Foundation

class MockHomePresenter: HomePresentationLogic {
    var invokedUpdateArticlesList = false
    var invokedUpdateArticlesListCount = 0
    var invokedUpdateArticlesListParameters: [Article]?
    
    var invokedDidFetchApiData = false
    var invokedDidFetchApiDataCount = 0
    
    var invokedWillFetchApiData = false
    var invokedWillFetchApiDataCount = 0
    
    var invokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (error: Error, Void)?
    
    var invokedShowLoader = false
    var invokedShowLoaderCount = 0
    
    func updateArticlesList(_ articles: [Article]) {
        invokedUpdateArticlesList = true
        invokedUpdateArticlesListCount += 1
        invokedUpdateArticlesListParameters = articles
    }
    
    func didFetchApiData() {
        invokedDidFetchApiData = true
        invokedDidFetchApiDataCount += 1
    }
    
    func willFetchApiData() {
        invokedWillFetchApiData = true
        invokedWillFetchApiDataCount += 1
    }
    
    func showError(error: Error) {
        invokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (error, ())
    }
    
    func showLoader() {
        invokedShowLoader = true
        invokedShowLoaderCount += 1
    }
}
