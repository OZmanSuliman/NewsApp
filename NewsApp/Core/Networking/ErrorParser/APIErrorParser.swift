//
//  APIErrorParser.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

class APIErrorParser {

    // MARK: - Private -

    private func validationError(from json: [String: Any]) -> APIError? {
        guard let status = json[Strings.status.fullString()] as? Int,
              let errors = json[Strings.errors.fullString()] as? [String: [String]] else {
            return nil
        }

        // concatenate all error messages into single string
        let errorMessages = errors.flatMap { $1 }
        return BackendError(statusCode: status, message: errorMessages.joined(separator: "\n"), reason: .generic)
    }

    private func failure(from json: [String: Any]) -> APIError? {
        guard let success = json[Strings.succeeded.fullString()] as? Bool,
              let message = json[Strings.message.fullString()] as? String else {
            return nil
        }

        return success ? nil : BackendError(statusCode: -1001, message: message, reason: .requestTimeOut)
    }

    private func exception(from json: [String: Any], statusCode: Int) -> APIError? {
        guard let message = json[Strings.error.fullString()] as? String else { return nil }

        return BackendError(statusCode: statusCode, message: message, reason: .generic)
    }

    private func isCodeValid(_ statusCode: Int) -> Bool {
        return (200...299).contains(statusCode)
    }
}

extension APIErrorParser: APIErrorParsing {

    func parse(response: HTTPURLResponse, data: Data?) -> APIError? {
        guard let data = data,
              let json = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else {
            return isCodeValid(response.statusCode) ? nil : BackendError.serverError(withCode: response.statusCode)
        }

        return validationError(from: json) ?? exception(from: json, statusCode: response.statusCode) ?? failure(from: json)
    }
}

