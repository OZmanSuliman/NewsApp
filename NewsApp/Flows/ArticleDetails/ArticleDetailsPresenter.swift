//
//  ArticleDetailsPresenter.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol ArticleDetailsPresentationLogic {
    func updateArticle(_ article: NSAttributedString)
}

class ArticleDetailsPresenter {
    let viewController: ArticleDetailsDisplayLogic
    init(viewController: ArticleDetailsDisplayLogic) {
        self.viewController = viewController
    }
}

extension ArticleDetailsPresenter: ArticleDetailsPresentationLogic {
    func updateArticle(_ article: NSAttributedString) {
        self.viewController.updateArticle(article)
    }
}
