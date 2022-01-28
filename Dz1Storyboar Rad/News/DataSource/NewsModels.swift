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

    var sourceId: Int
    var date: Double

    var text: String
    var attachments: [Attachment]?

    var comments: CommentModel
    var likes: LikeModel
    var reposts: Int

    enum CodingKeys: String, CodingKey {

        case sourceId = "source_id"
        case date = "date"

        case text = "text"
        case attachments = "attachments"

        case likes = "likes"
        case comments = "comments"
        case reposts = "reposts"
    }

    init(json:[String:Any]) {
        self.init()
        self.date = json["date"] as? Double ?? .zero
        self.sourceId = json["source_id"] as? Int ?? .zero
        self.text = json["text"] as? String ?? ""
        if let list = json["attachments"] as? [[String:Any]] {
            self.attachments = []
            for item in list {
                self.attachments?.append(Attachment(json: item))
            }
        }
        if let item = json["likes"] as? [String:Any] {
            self.likes = LikeModel(json: item)
        }
        if let item = json["comments"] as? [String:Any] {
            self.comments = CommentModel(json: item)
        }
        self.reposts = (json["reposts"] as? [String:Any])?["count"] as? Int ?? .zero
    }
    init() {
        self.date = .zero
        self.text = ""
        self.sourceId = .zero
        self.attachments = []
        self.likes = LikeModel.init(json: [:])
        self.comments = CommentModel.init(json: [:])
        self.reposts = .zero
    }
}

struct Attachment: Codable {

    var type: String?
    var photo: PhotoNews?

    init (json: [String:Any]) {

        self.type = json["type"] as? String
        if let item = json["photo"] as? [String:Any] {
            self.photo = PhotoNews(json: item)
        }
    }
}

struct LikeModel: Codable {

    var count: Int

    init (json: [String:Any]) {
        self.count = json["count"] as? Int ?? .zero
    }
}

struct CommentModel: Codable {

    var count: Int

    init (json: [String:Any]) {
        self.count = json["count"] as? Int ?? .zero
    }
}

struct PhotoNews: Codable {

    var id: Int?
    var imageList: [ImageNews]?
    

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case imageList = "sizes"
    }

    init (json: [String:Any]) {

        self.id = json["id"] as? Int
        if let list = json["sizes"] as? [[String:Any]] {
            self.imageList = []
            for item in list {
                self.imageList?.append(ImageNews.init(json: item))
            }
        }
    }
}

struct ImageNews: Codable {

    var type: String?
    var url: String?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case url = "url"
    }

    init(json:[String:Any]) {

        self.type = json["type"] as? String ?? ""
        self.url = json["url"] as? String ?? ""
    }
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
