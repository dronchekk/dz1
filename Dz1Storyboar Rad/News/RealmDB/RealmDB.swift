//
//  RealmDB.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 21.01.2022.
//

import Foundation
import RealmSwift

class RealmManager {

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

