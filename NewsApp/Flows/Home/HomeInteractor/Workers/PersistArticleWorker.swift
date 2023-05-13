//
//  PersistArticleWorker.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol PersistArticleLogic {
    func persistArticle(_ article: [Article])
}

class PersistArticleWorker {
    var dataBaseManager: DatabaseProtocol
    
    init(dataBaseManager: DatabaseProtocol) {
        self.dataBaseManager = dataBaseManager
    }
}

extension PersistArticleWorker: PersistArticleLogic {
    func persistArticle(_ article: [Article]) {
        DispatchQueue.main.async {
            self.dataBaseManager.save(article)
        }
    }
}
