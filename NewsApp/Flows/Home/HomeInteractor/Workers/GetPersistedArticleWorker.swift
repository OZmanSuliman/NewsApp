//
//  GetArticlesWorker.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation
protocol GetPersistedArticlesLogic {
    func getPersistedArticles() -> [Article]
}
class GetPersistedArticlesWorker {

    var dataBaseManager: DatabaseProtocol
    
    init(dataBaseManager: DatabaseProtocol) {
        self.dataBaseManager = dataBaseManager
    }
    
}


extension GetPersistedArticlesWorker: GetPersistedArticlesLogic {
    func getPersistedArticles() -> [Article] {
        let articles: [Article] = dataBaseManager.fetch()

        return articles
    }
}
