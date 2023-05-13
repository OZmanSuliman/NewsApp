//
//  MostPopularRequest.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

struct MostPopularRequest {
    var apiKey: String
    var section: String
    var period: String
    
    init(period: String) {
        self.apiKey = EnvironmentManager.shared.getApiKey()
        self.section = "all-sections"
        self.period = period
    }
}

extension MostPopularRequest: APIRequestProtocol {
    var endpoint: String {
        return API.mostPopularAPI.mostPopular.fullPath(withParameters: API.apiVersion, section, period, apiKey)
    }
}
