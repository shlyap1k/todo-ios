//
//  Todo.swift
//  todo-ios
//
//  Created by Shlyap1k on 07.12.2024.
//

import Foundation
import RealmSwift

class Todo: Object {
    init(id: Int, dateStart: Date, dateFinish: Date, name: String, descriptionText: String) {
        super.init()
        self.id = id
        self.dateStart = dateStart
        self.dateFinish = dateFinish
        self.name = name
        self.descriptionText = descriptionText
    }
    
    public override init() {
        super.init()
    }
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var dateStart: Date
    @Persisted var dateFinish: Date
    @Persisted var name: String
    @Persisted var descriptionText: String
}
