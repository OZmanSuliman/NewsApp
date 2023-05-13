//
//  HomePresenter.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol HomePresentationLogic {
    func updateArticlesList(_ articles: [Article])
    func didFetchApiData()
    func willFetchApiData()
    func showError(error: Error)
    func showLoader()
}

class HomePresenter {
    private let viewController: HomeDisplayLogic
    private var apiDataFetched = false
    private var articles: [Article] = [Article]()
    init(viewController: HomeDisplayLogic) {
        self.viewController = viewController
    }
}

extension HomePresenter: HomePresentationLogic {
    func updateArticlesList(_ articles: [Article]) {
        if apiDataFetched || !articles.isEmpty {
            self.articles = articles
            viewController.displayArticles(self.articles)
        }
    }
    
    func didFetchApiData() {
        self.apiDataFetched = true
    }
    
    func willFetchApiData() {
        self.apiDataFetched = false
    }
    
    func showError(error: Error) {
        guard articles.isEmpty else { return }
        if let error = error as? BackendError {
            self.viewController.showError(error: error.message)
        } else {
            self.viewController.showError(error: error.localizedDescription)
        }
    }
    
    func showLoader() {
        viewController.showLoader()
    }
}
