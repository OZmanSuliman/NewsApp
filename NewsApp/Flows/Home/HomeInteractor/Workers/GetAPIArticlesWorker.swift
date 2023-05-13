//
//  GetAPIArticlesWorker.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation
protocol GetAPIArticlesLogic {
    func getAPIArticles(period: String, completion: @escaping ([Article]?, Error?) -> Void)
}
class GetAPIArticlesWorker {

    let network: ArticlesNetworkServiceProtocol
    
    init(network: ArticlesNetworkServiceProtocol) {
        self.network = network
    }
    
}


extension GetAPIArticlesWorker: GetAPIArticlesLogic {
    func getAPIArticles(period: String, completion: @escaping ([Article]?, Error?) -> Void) {
        
        network.fetchResponse(period: period) { result in
            switch result {
            case .success(let baseModel):
                if let articles = baseModel.articles {
                    completion(articles, nil)
                } else {
                    completion(nil,NSError(domain: Strings.noArticle.fullString(), code: 500))
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
