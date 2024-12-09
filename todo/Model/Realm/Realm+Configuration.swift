//
//  Realm+Configuration.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation
import RealmSwift

extension RealmEnvironment {
    var configuredRealm: Realm? {
        let fileURL: String
        switch self {
        case .app:
            fileURL = "todo.realm"
        case .test:
            fileURL = "testTodo.realm"
        }
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent("Dng")
        if FileManager.default.fileExists(atPath: dataPath.absoluteString) == false {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            var config = Realm.Configuration()
            config.fileURL = dataPath.appendingPathComponent(fileURL)
            let realmReal = try Realm(configuration: config)
            return realmReal
        } catch {
            print(error.localizedDescription)
            if let realmForSyntax = try? Realm() {
                return realmForSyntax
            }
            return nil
        }
    }
}
