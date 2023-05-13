//
//  NetworkService.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation
// MARK: - ApiManagerProtocol

protocol NetworkingProtocol {
    func apiRequest<Response: APIResponseProtocol>(_ request: APIRequestProtocol, completion: @escaping  (Response?, Error?) -> Void)
}

typealias apiSuccess<Response: APIResponseProtocol> = Result<Response, Error>
typealias apiFailure = Error

// MARK: - HTTPMethod

enum HTTPMethod: String {
    case get
    case post
}

// MARK: - NetworkService

class NetworkService: NetworkingProtocol {
    private let errorParser: APIErrorParsing
    private let keychainService: KeychainProtocol
    init(errorParser: APIErrorParsing, keychainService: KeychainProtocol) {
        self.keychainService = keychainService
        self.errorParser = errorParser
    }
}

extension NetworkService {
    func apiRequest<Response>(_ request: APIRequestProtocol, completion: @escaping (Response?, Error?) -> Void) where Response: APIResponseProtocol {
        guard let url = URL(string: "\(request.endpoint)") else {
            
            completion(nil ,NSError(domain: Strings.invalidServerURL.fullString(), code: 500, userInfo: nil))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        request.headers.forEach {
            urlRequest.setValue($1, forHTTPHeaderField: $0)
        }
        urlRequest.httpMethod = request.method.rawValue
        
        let parameters = request.parameters
        if !parameters.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, NSError(domain: Strings.invalidResponse.fullString(), code: 500, userInfo: nil))
                    return
                }
                
                switch self.validateResponse(request: urlRequest, response: httpResponse, data: data) {
                case .success:
                    guard let data = data else {
                        completion(nil, NSError(domain: Strings.invalidResponse.fullString(), code: 500, userInfo: nil))
                        return
                    }
                    
                    
                    let apiResponse =  Response(with: data as Any)
                    completion(apiResponse, nil)
                    
                case let .failure(error):
                    completion(nil, error)
                }
            
        }.resume()
    }
    
    private func validateResponse(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Result<Void, Error> {
        if let error = errorParser.parse(response: response, data: data) {
            return .failure(error)
        }

        let statusCode = response.statusCode

        if !(statusCode <= 299 && statusCode >= 200) {
            return .failure(BackendError.serverError(withCode: statusCode))
        }

        return .success(())
    }
}
