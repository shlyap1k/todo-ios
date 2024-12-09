//
//  StorageService.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation
import RealmSwift

final class StorageServiceImpl: StorageService {
    private let storage: Realm?
    
    init(
        _ environment: RealmEnvironment
    ) {
        self.storage = environment.configuredRealm
    }
    
    func saveOrUpdateObject(object: Object) throws {
        guard let storage else { return }
        storage.writeAsync {
            storage.add(object, update: .all)
        }
    }
    
    func saveOrUpdateAllObjects(objects: [Object]) throws {
        try objects.forEach {
            try saveOrUpdateObject(object: $0)
        }
    }
    
    func delete(object: Object) throws {
        guard let storage else { return }
        try storage.write {
            storage.delete(object)
        }
    }
    
    func deleteAll() throws {
        guard let storage else { return }
        try storage.write {
            storage.deleteAll()
        }
    }
    
    func fetch<T: Object>(by type: T.Type) -> [T] {
        guard let storage else { return [] }
        return storage.objects(T.self).toArray()
    }
}
