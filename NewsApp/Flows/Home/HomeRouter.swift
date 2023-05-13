//
//  HomeRouter.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit

protocol HomeRoutingLogic {
    func navigateToDetails(article: Article)
}

class HomeRouter {
    let viewController: UIViewController
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeRoutingLogic {
    func navigateToDetails(article: Article) {
        let ArticleDetailsVC = ArticleDetailsViewController().config.createViewController(article: article)
        self.viewController.navigationController?.pushViewController(ArticleDetailsVC, animated: true)
    }
}
