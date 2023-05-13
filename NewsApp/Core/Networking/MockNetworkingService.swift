//
//  MockNetworkingService.swift
//  NewsAppTests
//
//  Created by Osman Ahmed on 13/05/2023.
//

import Foundation

class MockNetworkingService: NetworkingProtocol {
    var request: APIRequestProtocol?
    var response: APIResponseProtocol?
    var error: Error?
    
    func apiRequest<Response>(_ request: APIRequestProtocol, completion: @escaping (Response?, Error?) -> Void) where Response : APIResponseProtocol {
        self.request = request
        
        if let error = self.error {
            completion(nil, error)
            return
        }
        
        guard let response = self.response as? Response else {
            completion(nil, NSError(domain: Strings.invalidResponse.fullString(), code: 500, userInfo: nil))
            return
        }
        
        completion(response, nil)
    }
}
