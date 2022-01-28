//
//  PostNews.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 17.01.2022.
//

import UIKit
import Kingfisher
import SwiftyJSON
import RealmSwift
import Alamofire

public struct EmptyError: Error {

    public init(){}
}

class PostService: Operation {

    static var shared = {
        return PostService()
    }()

    func obtainAllNews(completion: @escaping AnyCompletion) {
        guard let url = URL(string: "https://api.vk.com/method/newsfeed.get?filters=post&start_from=next_from&count=5&access_token=\(Session.instance.token)&v=5.131")
        else {
            DispatchQueue.main.async {
                completion(.failure(EmptyError()))
            }
            return
        }
        let dataSource = NewsDataSource()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(EmptyError()))
                }
                return
            }
            let serviceGroup = DispatchGroup()
            let dic = Self.convertToDictionary(data: data)
            if let items = (dic?["response"] as? [String: Any])?["items"] as? [[String: Any]] {
                serviceGroup.enter()
                DispatchQueue.global(qos: .background).async {
                    var itemsModel: [PostItem] = []
                    for data in items {
                        itemsModel.append(PostItem.init(json: data))
                    }
                    dataSource.itemsList = itemsModel
                    serviceGroup.leave()
                }
            }
            if let profiles = (dic?["response"] as? [String: Any])?["profiles"] as? [[String: Any]] {
                serviceGroup.enter()
                DispatchQueue.global(qos: .background).async {
                    var itemsModel: [DetailProfiles] = []
                    for data in profiles {
                        var jsonData: Data?
                        do {
                            jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                        } catch {
                            continue
                        }
                        guard jsonData != nil else {continue}
                        var model: DetailProfiles?
                        do {
                            model = try JSONDecoder().decode(DetailProfiles.self, from: jsonData!)
                        } catch  {
                            continue
                        }
                        if model != nil {
                            itemsModel.append(model!)
                        }
                    }
                    dataSource.profilesList = itemsModel
                    serviceGroup.leave()
                }
            }

            if let groups = (dic?["response"] as? [String: Any])?["groups"] as? [[String: Any]] {
                serviceGroup.enter()
                DispatchQueue.global(qos: .background).async {
                    var itemsModel: [DetailGroup] = []
                    for data in groups {
                        guard let model = DetailGroup.init(json: data) else {continue}
                        itemsModel.append(model)
                    }
                    dataSource.groupList = itemsModel
                    serviceGroup.leave()
                }
            }
            serviceGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
                dataSource.convertToSectionModel()
                completion(.success(dataSource))
            }))
        }

        task.resume()
    }

    static func convertToDictionary(data: Data) -> [String: Any]? {
        do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }


    /*
    func matchRealm() {
        let realm = try! Realm()
        dataSource = realm.objects(FriendItems.self)
        token = dataSource?.observe { [weak self] changes in
            switch changes {
            case  let .update(results, deletions, insertions, modifications):
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .fade)
                self?.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .fade)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .fade)
                self?.tableView.endUpdates()
                print("UPDATED")

                print(self?.dataSource?.count)
            case .initial:
                self?.tableView.reloadData()
                print("Initial")
            case.error:
                print("Error")
            }
        }
    }


    func makeRequest() {

            let task = URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
                guard let data = data else { return }
                let dic = self?.convertToDictionary(data: data)
                guard let itemsData = (dic?["response"] as? [String: Any])?["items"] as? [[String: Any]] else {return}
                var friends: [FriendItems] = []
                for item in itemsData {
                    guard let model = FriendItems(json: item)
                    else {
                        continue
                    }
                    friends.append(model)
                }
                self?.dataSource = friends
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.realmManagerFriends.save(data: Array(friends))
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }


     */
}
