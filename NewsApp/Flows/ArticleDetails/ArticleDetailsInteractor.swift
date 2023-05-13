//
//  ArticleDetailsInteractor.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol ArticleDetailsBusinessLogic {
}

class ArticleDetailsInteractor {
    let presenter: ArticleDetailsPresentationLogic
    init(presenter: ArticleDetailsPresentationLogic) {
        self.presenter = presenter
    }
}

extension ArticleDetailsInteractor: ArticleDetailsBusinessLogic {

}
