//
//  MostPopularAPI.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

enum MostPopularAPI: String {
    case mostPopular = "mostpopular/%@/mostviewed/%@/%@.json?api-key=%@"
    
    /** Contains the full path to the endpoint */
    func fullPath(withParameters parameters: CVarArg...) -> String {
        var endpoint = self.rawValue

        if parameters.count > 0 {
            endpoint = String(format: endpoint, arguments: parameters)
        }

        return "\(EnvironmentManager.shared.getBaseUrl())/\(endpoint)"
    }
}
