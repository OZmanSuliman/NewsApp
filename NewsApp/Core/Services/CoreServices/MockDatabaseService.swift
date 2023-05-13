//
//  MockDatabaseService.swift
//  NewsApp
//
//  Created by Osman Ahmed on 13/05/2023.
//

import Foundation
import RealmSwift

class MockDatabaseService: DatabaseProtocol {

    var lastModel: Object?
    var models: [Object] = []
    var modelsWithSort: [Object] = []
    var foundModel: Object?
    var foundModels: [Object] = []
    var foundModelsWithSort: [Object] = []
    var savedModels: [Object] = []
    var updatedModels: [Object] = []
    var deletedModels: [Object] = []

    func fetchLast<Model>() -> Model? where Model : Object {
        return lastModel as? Model
    }

    func fetch<Model>() -> [Model] where Model : Object {
        return models as? [Model] ?? []
    }

    func fetchWithSort<Model>(by key: String, isAscending: Bool) -> [Model] where Model : Object {
        return modelsWithSort as? [Model] ?? []
    }

    func find<Model>(satisfying predicate: NSPredicate) -> Model? where Model : Object {
        return foundModel as? Model
    }

    func find<Model>(satisfying predicate: NSPredicate) -> [Model] where Model : Object {
        return foundModels as? [Model] ?? []
    }

    func findWithSort<Model>(satisfying predicate: NSPredicate, by key: String, isAscending: Bool) -> [Model] where Model : Object {
        return foundModelsWithSort as? [Model] ?? []
    }

    func save<Model>(_ objects: [Model]) where Model : Object {
        savedModels += objects
    }

    func save<Model>(_ object: Model) where Model : Object {
        savedModels.append(object)
    }

    func update<Model>(_ objects: [Model]) where Model : Object {
        updatedModels += objects
    }

    func update<Model>(_ object: Model) where Model : Object {
        updatedModels.append(object)
    }

    func clearDatabase() {
        models = []
        lastModel = nil
        modelsWithSort = []
        foundModels = []
        foundModel = nil
        foundModelsWithSort = []
        savedModels = []
        updatedModels = []
        deletedModels = []
    }

    func delete<Model>(object: Model) where Model : Object {
        deletedModels.append(object)
    }

    func delete<Model>(objects: [Model]) where Model : Object {
        deletedModels += objects
    }
}
