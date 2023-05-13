//
//  RemoveArticleWorker.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol RemoveArticleLogic {
    func removeArticle(_ article: Article)
    func removeArticles(_ articles: [Article])
}

class RemoveArticleWorker {
    var dataBaseManager: DatabaseProtocol
    
    init(dataBaseManager: DatabaseProtocol) {
        self.dataBaseManager = dataBaseManager
    }
}

extension RemoveArticleWorker: RemoveArticleLogic {
    func removeArticle(_ article: Article) {
        DispatchQueue.main.async {
            self.dataBaseManager.delete(object: article)
        }
    }
    
    func removeArticles(_ articles: [Article]) {
        DispatchQueue.main.async {
            self.dataBaseManager.clearDatabase() //(objects: articles)
        }
    }
}
