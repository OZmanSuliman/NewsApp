//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol HomeBusinessLogic {
    func fetchArticles(period: String)
    func removeArticle(_ article: Article)
}

class HomeInteractor {
    let presenter: HomePresentationLogic
    let getPersistedArticlesWorker: GetPersistedArticlesLogic
    let persistArticleWorker: PersistArticleLogic
    let removeArticleWorker: RemoveArticleLogic
    let getAPIArticlesWorker: GetAPIArticlesLogic
    private var articles = [Article]()
    init(presenter: HomePresentationLogic, database: DatabaseProtocol, network: ArticlesNetworkServiceProtocol) {
        self.presenter = presenter
        self.getPersistedArticlesWorker = GetPersistedArticlesWorker(dataBaseManager: database)
        self.persistArticleWorker = PersistArticleWorker(dataBaseManager: database)
        self.removeArticleWorker = RemoveArticleWorker(dataBaseManager: database)
        self.getAPIArticlesWorker = GetAPIArticlesWorker(network: network)
    }
}

extension HomeInteractor: HomeBusinessLogic {
    func fetchArticles(period: String) {
        DispatchQueue.global().sync {
            self.presenter.willFetchApiData()
            self.presenter.showLoader()
            self.getPersistedArticles()
            self.getAPIArticles(period: period) { response in
                guard let response else {
                    return
                }
                self.removeAllArticles()
                self.persistArticle(response)
            }
        }
    }
    
    private func getPersistedArticles() {
        DispatchQueue.main.async {
            self.articles = self.getPersistedArticlesWorker.getPersistedArticles()
            self.presenter.updateArticlesList(self.articles)
        }
    }
    
    private func getAPIArticles(period: String, completion: @escaping ([Article]?) -> Void) {
        getAPIArticlesWorker.getAPIArticles(period: period, completion: { articles, error in
            self.presenter.didFetchApiData()
            if let error {
                self.presenter.showError(error: error)
            } else if let articles {
                completion(articles)
            }
        })
    }
    
    private func persistArticle(_ article: [Article]) {
        DispatchQueue.main.async {
            self.persistArticleWorker.persistArticle(article)
            self.getPersistedArticles()
        }
    }

     func removeArticle(_ article: Article) {
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.async {
            self.removeArticleWorker.removeArticle(article)
            group.leave()
        }
        group.notify(queue: .main) {
            self.getPersistedArticles()
        }
    }
    
    private func removeAllArticles() {
        DispatchQueue.main.async {
            let articles = self.getPersistedArticlesWorker.getPersistedArticles()
            self.removeArticleWorker.removeArticles(articles)
        }
    }
}
