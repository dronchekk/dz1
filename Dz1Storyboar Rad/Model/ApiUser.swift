//
//  ApiUser.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 24.11.2021.
//

import Foundation
import RealmSwift
import Realm

@objcMembers class FriendItems: Object, Codable {
    dynamic var first_name: String = ""
     dynamic var last_name: String = ""
//    var screen_name: String
//    var is_closed: Bool
//    var type: String
//    var is_admin: Bool
//    var is_member: Bool
//    var is_advertiser: Bool
     dynamic var photo_50: String? = ""
//    var photo_100: String?
//    var photo_200: String?

    required init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            first_name = try container.decode(String.self, forKey: .first_name)
            last_name = try container.decode(String.self, forKey: .last_name)
            photo_50 = try container.decode(String.self, forKey: .photo_50)
            super.init()
        }

    required override init()
     {
         super.init()
     }


//    enum CodingKeys: String, CodingKey {
//        case first_name = "first_name"
//        case last_name = "last_name"
//        case screen_name = "screen_name"
//        case is_closed = "is_closed"
//        case type = "type"
//        case is_admin = "is_admin"
//        case is_member = "is_member"
//        case is_advertiser = "is_advertiser"
//        case photo_50 = "photo_50"
//        case photo_100 = "photo_100"
//        case photo_200 = "photo_200"
//    }

    public convenience init?(json: [String: Any]?){
          guard let json = json else {
              return nil
          }
          self.init()

        self.first_name = json["first_name"] as? String ?? "Error first_name"
          self.last_name = json["last_name"] as? String ?? "Error last_name"
//          self.screen_name = json["screen_name"] as? String ?? "Error screen_name"
          self.photo_50 = json["photo_50"] as? String
  }

  public init (first_name: String? = nil,
               last_name: String? = nil,
               photo_50: String? = nil) {
      self.first_name = first_name ?? "Error first_name"
      self.last_name = last_name ?? "Error last_name"
      self.photo_50 = photo_50
  }
}

