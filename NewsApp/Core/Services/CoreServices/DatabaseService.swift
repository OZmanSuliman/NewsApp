//
//  DatabaseService.swift
//  NewsApp
//
//  Created by Osman Ahmed on 12/05/2023.
//

import Foundation
import RealmSwift

typealias DatabaseProtocol = DatabaseReading & DatabaseWriting

// To be used everywhere if needed rather than creating new realm
var realmMain: Realm?

protocol DatabaseReading {

    func fetchLast<Model: Object>() -> Model?
    func fetch<Model: Object>() -> [Model]
    func fetchWithSort<Model: Object>(by key: String, isAscending: Bool) -> [Model]
    func find<Model: Object>(satisfying predicate: NSPredicate) -> Model?
    func find<Model: Object>(satisfying predicate: NSPredicate) -> [Model]
    func findWithSort<Model: Object>(satisfying predicate: NSPredicate, by key: String, isAscending: Bool) -> [Model]
}

protocol DatabaseWriting {

    func save<Model: Object>(_ objects: [Model])
    func save<Model: Object>(_ object: Model)
    func update<Model: Object>(_ objects: [Model])
    func update<Model: Object>(_ object: Model)
    func clearDatabase()
    func delete<Model: Object>(object: Model)
    func delete<Model: Object>(objects: [Model])
}

class DatabaseService {

    static func configureDataMigration() {
        do {
            let config = Realm.Configuration(
                schemaVersion: UInt64(AppStoredSettings.realmDatabaseVersion),
                migrationBlock: nil)
            Realm.Configuration.defaultConfiguration = config
            realmMain = try Realm(configuration: config)
        } catch let error {
            print(error)
        }
    }

}

// MARK: - DatabaseReading -

extension DatabaseService: DatabaseReading {

    func fetchLast<Model: Object>() -> Model? {
        return fetch().last
    }

    func fetch<Model: Object>() -> [Model] {
        guard let models = realmMain?.objects(Model.self) else { return [] }
        return Array(models)
    }

    func fetchWithSort<Model: Object>(by key: String, isAscending: Bool = true) -> [Model] {
        guard let models = realmMain?.objects(Model.self).sorted(byKeyPath: key, ascending: isAscending) else { return [] }
        return Array(models)
    }

    func find<Model: Object>(satisfying predicate: NSPredicate) -> Model? {
        guard let model = realmMain?.objects(Model.self).filter(predicate) else { return nil }
        return model.last
    }

    func find<Model: Object>(satisfying predicate: NSPredicate) -> [Model] {
        guard let models = realmMain?.objects(Model.self).filter(predicate) else { return [] }
        return Array(models)
    }

    func findWithSort<Model: Object>(satisfying predicate: NSPredicate, by key: String, isAscending: Bool = true) -> [Model] {
        guard let models = realmMain?.objects(Model.self).filter(predicate).sorted(byKeyPath: key, ascending: isAscending) else { return [] }
        return Array(models)
    }

}

// MARK: - DatabaseWriting -

extension DatabaseService: DatabaseWriting {

    func save<Model: Object>(_ objects: [Model]) {
        try? realmMain?.write {
            objects.forEach { realmMain?.create(Model.self, value: $0, update: .modified) }
        }
    }

    func save<Model: Object>(_ object: Model) {
        save([object])
    }

    func update<Model: Object>(_ objects: [Model]) {
        try? realmMain?.write {
            objects.forEach { realmMain?.add($0, update: .modified) }
        }
    }

    func update<Model: Object>(_ object: Model) {
        update([object])
    }

    func clearDatabase() {
        try? realmMain?.write {
            realmMain?.deleteAll()
        }
    }

    func delete<Model: Object>(object: Model) {
        try? realmMain?.write {
            realmMain?.delete(object)
        }
    }

    func delete<Model: Object>(objects: [Model]) {
        try? realmMain?.write {
            objects.forEach { realmMain?.delete($0) }
        }
    }

}
