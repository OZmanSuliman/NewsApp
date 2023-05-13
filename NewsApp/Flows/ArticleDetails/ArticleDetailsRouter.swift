//
//  ArticleDetailsRouter.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol ArticleDetailsRouterLogic {
}
class ArticleDetailsRouter {
    let viewController: ArticleDetailsViewController
    init(viewController: ArticleDetailsViewController) {
        self.viewController = viewController
    }
}

extension ArticleDetailsRouter: ArticleDetailsRouterLogic {
}
