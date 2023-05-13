//
//  ArticlesNetworkService.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

protocol ArticlesNetworkServiceProtocol {
    func fetchResponse(period: String, completion: @escaping (Result<MostPopularResponse, BackendError>) -> Void)
}

class ArticlesNetworkService: ArticlesNetworkServiceProtocol {
    private let networkingManager: NetworkingProtocol
    private let keychainService: KeychainProtocol
    init(networkingManager: NetworkingProtocol, keychainService: KeychainProtocol) {
        self.networkingManager = networkingManager
        self.keychainService = keychainService
    }
    
    func fetchResponse(period: String, completion: @escaping (Result<MostPopularResponse, BackendError>) -> Void) {
        let request: MostPopularRequest = MostPopularRequest(period: period)
        
        networkingManager.apiRequest(request) { (response: MostPopularResponse?, error) in
            if let backendError = error as? BackendError {
                    completion(.failure(backendError))
            } else if let response {
                completion(.success(response))
            }  else if let error {
                let backendError = BackendError(statusCode: 400, message: error.localizedDescription, reason: .generic)
                completion(.failure(backendError))
            }
        }
    }
}

