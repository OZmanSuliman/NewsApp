//
//  ArticleDetailsPresenter.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol ArticleDetailsPresentationLogic {
}

class ArticleDetailsPresenter {
    let viewController: ArticleDetailsDisplayLogic
    init(viewController: ArticleDetailsDisplayLogic) {
        self.viewController = viewController
    }
}

extension ArticleDetailsPresenter: ArticleDetailsPresentationLogic {
}
