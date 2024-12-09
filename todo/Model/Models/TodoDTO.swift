//
//  Todo.swift
//  todo-ios
//
//  Created by Shlyap1k on 07.12.2024.
//

import Foundation

struct TodoDTO {
    var id: Int
    var dateStart: Date
    var dateFinish: Date
    var name: String
    var descriptionText: String
}

extension TodoDTO {
    init(object: TodoObject) {
        id = object.id
        dateStart = object.dateStart
        dateFinish = object.dateFinish
        name = object.name
        descriptionText = object.descriptionText
    }
}
