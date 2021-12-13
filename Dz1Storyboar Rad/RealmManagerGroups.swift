//
//  RealmManagerGroups.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 06.12.2021.
//

import Foundation
import RealmSwift

class RealmManagerGroups {

    func save(data: [GroupItems]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func getGroups() -> [GroupItems]{
        let realm = try! Realm()
        let listGroups = realm.objects(GroupItems.self)
        return Array(listGroups)
    }
}
