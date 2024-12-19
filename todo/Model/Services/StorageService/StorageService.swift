//
//  StorageServi.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation
import RealmSwift

protocol StorageService {
    func saveOrUpdateObject(object: Object) throws
    
    func saveOrUpdateAllObjects(objects: [Object]) throws
    
    func delete(object: Object) throws
    
    func deleteAll() throws
    
    func fetch<T: Object>(by type: T.Type, filter: NSPredicate?) -> [T]
}
