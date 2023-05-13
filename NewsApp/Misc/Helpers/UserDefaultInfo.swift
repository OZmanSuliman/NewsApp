//
//  UserDefaultInfo.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation

internal struct UserDefaultInfo<Value> {
   var key: String
   var defaultValue: Value
}

internal extension UserDefaultInfo {

   func get() -> Value {
       guard let valueUntyped = UserDefaults.standard.object(forKey: self.key), let value = valueUntyped as? Value else {
           return self.defaultValue
       }

       return value
   }

   func set(_ value: Value) {
       UserDefaults.standard.set(value, forKey: self.key)
   }

   func getObject<T: Decodable>() -> T? {
       if let data = UserDefaults.standard.data(forKey: self.key) {
           return try? JSONDecoder().decode(T.self, from: data)
       } else {
           return nil
       }
   }

   func setObject<T: Encodable>(encodable: T) {
       if let data = try? JSONEncoder().encode(encodable) {
           UserDefaults.standard.setValue(data, forKey: self.key)
       }
   }

}

enum UserDefaultsEnum {
    // MARK: - Authorization -
    private static var lastUpdatedApiTokenTimeInfo = UserDefaultInfo(key: Strings.lastUpdatedApiTokenTimeInfo.fullString(), defaultValue: Date())
    static var lastUpdatedApiTokenTime: Date { // Date when the api tokens are saved/updated
        get { return lastUpdatedApiTokenTimeInfo.get() }
        set { lastUpdatedApiTokenTimeInfo.set(newValue) }
    }
    
    static var isAuthorized: Bool {
        return hasApiAccessToken
    }

    private static var hasApiAccessTokenInfo = UserDefaultInfo(key: Strings.hasApiAccessTokenInfo.fullString(), defaultValue: false)
    static var hasApiAccessToken: Bool {
        get { return hasApiAccessTokenInfo.get() }
        set { hasApiAccessTokenInfo.set(newValue) }
    }
}

