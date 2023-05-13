//
//  Strings.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation


enum Strings: String {
    case EnvironmentVariables
    case Configuration
    case plist
    case noSetting = "No <%@> setting has been found"
    case environmentVariablesPlist = "EnvironmentVariables.plist"
    case unableToLoadPLIST = "Unable to load PLIST at path: %@"
    case PropertyNotOfType = "Property %@ is not of type %@"
    case unauthorized = "Unauthorized"
    case serverError = "Server Error %@"
    case requestTimedOut = "The request timed out"
    case invalidResponse
    case invalidServerURL
    case networkIssue = "Network Not Available"
    case appStateSerialQueue
    case identifier
    case status
    case errors
    case succeeded
    case message
    case error
    case access_token
    case refresh_token
    case expires_token_time
    case lastUpdatedApiTokenTimeInfo
    case hasApiAccessTokenInfo
    
    // colors
    case Primery

    // images
    case HeaderBg = "Header-bg"
    case backButton = "Chevron-left-BlackColor"
    case trash = "trash.fill"
    case logo
    
    // Text
    case Articles = "TOP NEWS"
    case NewsApp = "News App"
    case noArticle = "No Article To Show"
    case Delete
    case ArticleDate = "Article Date"
    case total = "Total"
    case periodTitle = "Articles Within.."
    case day = "Day/Days"
    
    //Lottie
    case emptyList
    case errorFile
    case loader
    case filterIcon
    
    func fullString(withParameters parameters: CVarArg...) -> String {
        var str = rawValue

        if parameters.count > 0 {
            str = String(format: str, arguments: parameters)
        }

        return str
    }
}
