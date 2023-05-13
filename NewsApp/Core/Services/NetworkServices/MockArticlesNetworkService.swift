//
//  MockArticlesNetworkService.swift
//  NewsApp
//
//  Created by Osman Ahmed on 13/05/2023.
//

import Foundation

class MockArticlesNetworkService: ArticlesNetworkServiceProtocol {
    var response: MostPopularResponse?
    var error: BackendError?
    var invokedFetchResponse = false
    var invokedFetchResponseCount = 0
    var invokedFetchResponseParameters: (period: String, completion: ((Result<MostPopularResponse, BackendError>) -> Void))?
    
    init(response: MostPopularResponse? = nil, error: BackendError? = nil, invokedFetchResponse: Bool = false, invokedFetchResponseCount: Int = 0, invokedFetchResponseParameters: (period: String, completion: (Result<MostPopularResponse, BackendError>) -> Void)? = nil) {
        self.response = response
        self.error = error
        self.invokedFetchResponse = invokedFetchResponse
        self.invokedFetchResponseCount = invokedFetchResponseCount
        self.invokedFetchResponseParameters = invokedFetchResponseParameters
    }
    
    func fetchResponse(period: String, completion: @escaping (Result<MostPopularResponse, BackendError>) -> Void) {
        invokedFetchResponse = true
        invokedFetchResponseCount += 1
        invokedFetchResponseParameters = (period, completion)
        
        if let error = error {
            completion(.failure(error))
        } else if let response = response {
            completion(.success(response))
        }
    }
}
