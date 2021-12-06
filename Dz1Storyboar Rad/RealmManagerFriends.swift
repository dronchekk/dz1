//
//  RealmManagerFriends.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 06.12.2021.
//

import Foundation
import RealmSwift

class RealmManagerFriends {

    func save(data: [FriendItems]) {
        do {
            let realm = try Realm()
//            print(realm.configuration.fileURL)
            realm.beginWrite()
            realm.add(data)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

    func getFriends() -> [FriendItems]{
        let realm = try! Realm()
        let listFriends = realm.objects(FriendItems.self)
        return Array(listFriends)
    }
}
