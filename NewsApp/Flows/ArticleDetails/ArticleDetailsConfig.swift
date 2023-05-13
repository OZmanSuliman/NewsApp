//
//  ArticleDetailsConfig.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit

class ArticleDetailsConfig {
    func createViewController(article: Article) -> UIViewController {
        let vc = ArticleDetailsViewController.initFromNib()
        let router = ArticleDetailsRouter(viewController: vc)
        let presenter = ArticleDetailsPresenter(viewController: vc)
        let interactor = ArticleDetailsInteractor(presenter: presenter)
        vc.interactor = interactor
        vc.router = router
        vc.article = article
        return vc
    }
}
