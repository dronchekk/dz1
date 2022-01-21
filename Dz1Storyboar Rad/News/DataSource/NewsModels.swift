//
//  NewsModels.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 17.01.2022.
//

import UIKit
import RealmSwift
import Realm

struct PostItem: Codable {

    let sourceId: Int
    let date: Double

    let text: String
    let attachments: [Attachment]?

    let comments: CommentModel
    let likes: LikeModel
    let reposts: Int

    enum CodingKeys: String, CodingKey {

        case sourceId = "source_id"
        case date

        case text
        case attachments

        case likes
        case comments
        case reposts
    }
}

struct Attachment: Codable {

    let type: String?
    let photo: PhotoNews?
}

struct LikeModel: Codable {

    let count: Int
}

struct CommentModel: Codable {

    let count: Int
}

struct PhotoNews: Codable {

    let id: Int?
    let imageList: [ImageNews]?
    

    enum CodingKeys: String, CodingKey {

        case id
        case imageList = "sizes"
    }
}

struct ImageNews: Codable {

    let type: String?
    let url: String?

}

@objcMembers class DetailGroup: Object, Codable {

    dynamic var id: Int = 0
    dynamic var name: String = ""
    dynamic var photoUrl: String = ""
    dynamic var type: String = ""

    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        photoUrl = try container.decode(String.self, forKey: .photoUrl)
        type = try container.decode(String.self, forKey: .type)

        super.init()
    }

    required override init()
    {
        super.init()
    }

    public convenience init?(json: [String: Any]?) {
        guard let json = json else {
            return nil
        }
        self.init()

        self.id = json["id"] as? Int ?? 0
        self.name = json["name"] as? String ?? "Error name"
        self.photoUrl = json["photo_50"] as? String ?? "Error photoUrl"
        self.type = json["type"] as? String ?? "Error type"

    }

    public init (id: Int? = nil,
                 name: String? = nil,
                 photoUrl: String? = nil,
                 type: String? = nil)
    {
        self.id = id ?? 0
        self.name = name ?? "Error name"
        self.photoUrl = name ?? "Error photoUrl"
        self.type = name ?? "Error type"
    }
}

@objcMembers class DetailProfiles: Object, Codable {

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

    public convenience init?(json: [String: Any]?) {
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
