//
//  KeychainService.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation
import SwiftKeychainWrapper

typealias KeychainProtocol = KeychainWriting & KeychainReading

protocol KeychainWriting {

    func saveAccessToken(_ token: String?)
    func saveRefreshToken(_ token: String?)
    func saveExpiresTokenTime(_ token: Int?)
    func removeAuthState()
}

protocol KeychainReading {

    func fetchAccessToken() -> String?
    func fetchRefreshToken() -> String?
    func fetchExpiresTokenTime() -> Int?
}

class KeychainService {

    private let keychain = KeychainWrapper.standard
}

// MARK: - KeychainWriting -

extension KeychainService: KeychainWriting {

    func saveAccessToken(_ token: String?) {
        guard let token = token else { return }
        keychain.set(token, forKey: .accessToken)
    }

    func saveRefreshToken(_ token: String?) {
        guard let token = token else { return }
        keychain.set(token, forKey: .refreshToken)
    }

    func saveExpiresTokenTime(_ token: Int?) {
        guard let token = token else { return }
        keychain.set(token, forKey: .expiresTokenTime)
    }

    func removeAuthState() {
        keychain.removeObject(forKey: .accessToken)
        keychain.removeObject(forKey: .refreshToken)
        keychain.removeObject(forKey: .expiresTokenTime)

        UserDefaultsEnum.hasApiAccessToken = false
    }
}

// MARK: - KeychainReading -

extension KeychainService: KeychainReading {

    func fetchAccessToken() -> String? {
        guard let data = keychain.string(forKey: .accessToken) else { return nil }
        return data
    }

    func fetchRefreshToken() -> String? {
        guard let data = keychain.string(forKey: .refreshToken) else { return nil }
        return data
    }

    func fetchExpiresTokenTime() -> Int? {
        guard let data = keychain.integer(forKey: .expiresTokenTime) else { return nil }
        return data
    }
}

// MARK: - Keys -

private extension String {

    static let accessToken = Strings.access_token.fullString()
    static let refreshToken = Strings.refresh_token.fullString()
    static let expiresTokenTime = Strings.expires_token_time.fullString()
}


