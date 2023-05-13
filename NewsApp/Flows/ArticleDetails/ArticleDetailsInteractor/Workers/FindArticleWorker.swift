//
//  FindArticlesWorker.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol FindArticlesWorkerLogic {
    func findArticles(article: Article) -> Article
}

class FindArticlesWorker {
    var dataBaseManager: DatabaseProtocol
    
    init(dataBaseManager: DatabaseProtocol) {
        self.dataBaseManager = dataBaseManager
    }
}


extension FindArticlesWorker: FindArticlesWorkerLogic {
    func findArticles(article: Article) -> Article {
        let predicate = NSPredicate(format: "id = %@", article.id)
        let updatedArticles: Article? = dataBaseManager.find(satisfying: predicate)
        guard let updatedArticles else { return article }
        return updatedArticles
    }
}
