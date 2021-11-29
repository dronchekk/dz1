//
//  ApiGroup.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 24.11.2021.
//

import Foundation

class GroupItems: Codable {
    var id: Int
    var name: String
    var screen_name: String
//    var is_closed: Bool
//    var type: String
//    var is_admin: Bool
//    var is_member: Bool
//    var is_advertiser: Bool
    var photo_50: String?
//    var photo_100: String?
//    var photo_200: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screen_name = "screen_name"
//        case is_closed = "is_closed"
//        case type = "type"
//        case is_admin = "is_admin"
//        case is_member = "is_member"
//        case is_advertiser = "is_advertiser"
        case photo_50 = "photo_50"
//        case photo_100 = "photo_100"
//        case photo_200 = "photo_200"
    }

    public convenience init?(json: [String: Any]?){
          guard let json = json else {
              return nil
          }
          self.init()

    self.id = json["id"] as? Int ?? 0
          self.name = json["name"] as? String ?? "Error name"
          self.screen_name = json["screen_name"] as? String ?? "Error screen_name"
          self.photo_50 = json["photo_50"] as? String
  }

  public init (name: String? = nil,
               id: Int? = nil,
               screen_name: String? = nil,
               photo_50: String? = nil) {
      self.name = name ?? "Error name"
      self.id = id ?? 0
      self.screen_name = screen_name ?? "Error screen_name"
      self.photo_50 = photo_50
  }
}

