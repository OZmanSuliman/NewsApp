//
//  HomeConfig.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import UIKit

class HomeConfiguration {
    func createViewController() -> UIViewController {
        let vc = HomeViewController.initFromNib()
        let router = HomeRouter(viewController: vc)
        let presenter = HomePresenter(viewController: vc)
        let interactor = HomeInteractor(presenter: presenter, database: ServicesFactory.shared.makeDatabaseService(), network: ServicesFactory.shared.makeArticlesNetworkService())
        vc.interactor = interactor
        vc.router = router
        
        return vc
    }
}
