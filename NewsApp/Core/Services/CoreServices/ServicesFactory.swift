//
//  ServicesFactory.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

class ServicesFactory {
    static let shared = ServicesFactory()

    func makeArticlesNetworkService() -> ArticlesNetworkServiceProtocol {
        return ArticlesNetworkService(networkingManager: makeNetworkService(), keychainService: makeKeychainService())
    }

    func makeKeychainService() -> KeychainProtocol {
        return KeychainService()
    }

    func makeDatabaseService() -> DatabaseProtocol {
        return DatabaseService()
    }
    
    private func makeErrorParser() -> APIErrorParsing {
        return APIErrorParser()
    }

    private func makeNetworkService() -> NetworkingProtocol {
        return NetworkService(errorParser: makeErrorParser(), keychainService: makeKeychainService())
    }
}

