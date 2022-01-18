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

class PostService {

    static var shared = {
        return PostService()
    }()

    func obtainAllNews(completion: @escaping VoidCompletion) {
        guard let url = URL(string: "http://api.vk.com/method/newsfeed.get?fields=items,profiles,groups&access_token=\(Session.instance.token)&v=5.131")
        else {
            DispatchQueue.main.async {
                completion(.failure(EmptyError()))
            }
            return
        }
        let serviceGroup = DispatchGroup()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(EmptyError()))
                }
                return
            }
            let dic = Self.convertToDictionary(data: data)
            if let items = dic?["items"]{
                let itemsQueue = DispatchQueue.global(qos: .background)
                serviceGroup.enter()
                itemsQueue.async {


                    serviceGroup.leave()
                }
            }
            if let profiles = dic?["profiles"]{
                let itemsQueue = DispatchQueue.global(qos: .background)
                serviceGroup.enter()
                itemsQueue.async {


                    serviceGroup.leave()
                }
            }
            if let group = dic?["group"]{
                let itemsQueue = DispatchQueue.global(qos: .background)
                serviceGroup.enter()
                itemsQueue.async {


                    serviceGroup.leave()
                }
            }
        }
        task.resume()

        serviceGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: { [weak self] in
            guard let self = self else {
                completion(.failure(EmptyError()))
                return
            }
            completion(.success(()))
        }))
    }

    static func convertToDictionary(data: Data) -> [String: Any]? {
        do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }


//    let url = URL(string: "http://api.vk.com/method/newsfeed.get?fields=items,profiles,groups&access_token=\(Session.instance.token)&v=5.131")


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
