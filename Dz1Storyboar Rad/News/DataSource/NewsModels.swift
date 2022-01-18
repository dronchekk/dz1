//
//  NewsModels.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 17.01.2022.
//

import Foundation
import RealmSwift
import Realm

@objcMembers class PostItems: Object, Codable {
    dynamic var text: String = ""
    dynamic var comments: Int = 0
    dynamic var likes: Int = 0
    dynamic var reposts: Int = 0
    

    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        text = try container.decode(String.self, forKey: .text)
        comments = try container.decode(Int.self, forKey: .comments)
        likes = try container.decode(Int.self, forKey: .likes)
        reposts = try container.decode(Int.self, forKey: .reposts)

        super.init()
    }

    required override init()
    {
        super.init()
    }

    public convenience init?(json: [String: Any]?){
        guard let json = json else {
            return nil
        }
        self.init()

        self.text = json["text"] as? String ?? "Error text"
        self.comments = json["comments"] as? Int ?? 0
        self.likes = json["likes"] as? Int ?? 0
        self.reposts = json["reposts"] as? Int ?? 0

    }

    public init (text: String? = nil,
                 comments: Int? = nil,
                 likes: Int? = nil,
                 reposts: Int? = nil
                 )
    {
        self.text = text ?? "Error name"
        self.comments = comments ?? 0
        self.likes = likes ?? 0
        self.reposts = reposts ?? 0
    }
}

//@objcMembers class PostGroups: Object, Codable {
//    //??
//}

@objcMembers class PostProfiles: Object, Codable {
    dynamic var screen_name: String = ""
    dynamic var photo_50: String = ""

    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        screen_name = try container.decode(String.self, forKey: .screen_name)
        photo_50 = try container.decode(String.self, forKey: .photo_50)
        super.init()
    }

    required override init()
    {
        super.init()
    }

    public convenience init?(json: [String: Any]?){
        guard let json = json else {
            return nil
        }
        self.init()

        self.screen_name = json["screen_name"] as? String ?? "Error text"
        self.photo_50 = json["photo_50"] as? String ?? "Error photo"

    }

    public init (screen_name: String? = nil,
                 photo_50: String? = nil)
    {
        self.screen_name = screen_name ?? "Error name"
        self.photo_50 = photo_50 ?? "Error photo"
    }
}
