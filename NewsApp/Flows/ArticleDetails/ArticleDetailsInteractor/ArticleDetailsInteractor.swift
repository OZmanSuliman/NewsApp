//
//  ArticleDetailsInteractor.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol ArticleDetailsBusinessLogic {
    func fetchArticle(_ article: Article)
}

class ArticleDetailsInteractor {
    let presenter: ArticleDetailsPresentationLogic
    init(presenter: ArticleDetailsPresentationLogic) {
        self.presenter = presenter
    }
}

extension ArticleDetailsInteractor: ArticleDetailsBusinessLogic {
    func fetchArticle(_ article: Article) {
        guard let urlString = article.url, let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
                
                if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
                    self.presenter.updateArticle(attributedString)
                }
            }
        }

        task.resume()
    }
}
