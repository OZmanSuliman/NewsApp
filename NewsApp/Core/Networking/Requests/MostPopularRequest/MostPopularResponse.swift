//
//  MostPopularResponse.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

class MostPopularResponse: APIResponseProtocol {
    var articles: [Article]?
    required init(with json: Any) {
        guard let jsonData = json as? Data else { return }
        let decoder = JSONDecoder()

        do {
            let articlesBase = try decoder.decode(MostPopularArticles_Base.self, from: jsonData)
            articles = articlesBase.articles
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
}
