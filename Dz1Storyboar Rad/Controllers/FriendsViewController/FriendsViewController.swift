//
//  FriendsViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 16.10.2021.
//

import UIKit
import Kingfisher
import SwiftyJSON
import RealmSwift


class FriendsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var token: NotificationToken?
    let realmManagerFriends = RealmManagerFriends()
    var dataSource: Results<FriendItems>?
//    let url = URL(string: "http://api.vk.com/method/friends.get?fields=first_name,photo_50&access_token=\(Session.instance.token)&v=5.131")
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromFriendsToGallerySegue = "fromFriendsToGallery"
//    var friendsArray = [Friend]()
//    var savedFriendsArray = [Friend]()
//    var arrayLetter = [String]()

    //заголовок первых букв
//    func arrayLetter(sourceArray: [Friend]) -> [String] {
//        var resultArray = [String]()
//
//        for item in sourceArray {
//            let nameLetter = String(item.name.prefix(1))
//            if !resultArray.contains(nameLetter.lowercased()) {
//                resultArray.append(nameLetter.lowercased())
//            }
//        }
//        return resultArray.sorted { firstItem, secondItem in
//            firstItem < secondItem
//        }
//    }
//
//    func formArrayLetter() {
//        self.arrayLetter = arrayLetter(sourceArray: self.friendsArray)
//    }


    //маленькие массивчики под первые буквы
//    func arrayByLetter(sourceArray: [Friend], letter: String) -> [Friend] {
//        var resultArray = [Friend]()
//        for item in sourceArray {
//            let nameLetter = String(item.name.prefix(1)).lowercased()
//            if nameLetter == letter.lowercased() {
//                resultArray.append(item)
//            }
//    }
//        return resultArray
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        makeRequest()
        configureTableView()
//        fillFriendsArray()
//        formArrayLetter()
//        savedFriendsArray = friendsArray
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
//        searchBar.delegate = self
            matchRealm()
        //tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToGallerySegue,
           // let sourceVC = segue.source as? FriendsViewController,
            let destinationVC = segue.destination as? GalleryViewController,
            let friend = sender as? FriendItems {
           // destinationVC.photos = friend.photos
        }
    }

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


    @IBAction func addFriend(_ sender: Any) {
        let realm = try! Realm()
        realm .beginWrite()
        let friend = FriendItems()
        friend.first_name = "Bob"
        friend.last_name = "Cat"
        //friend.photo_50 = ""
        realm.add(friend)
        try! realm.commitWrite()
    }

//    func makeRequest() {
//
//            let task = URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
//                guard let data = data else { return }
//                let dic = self?.convertToDictionary(data: data)
//                guard let itemsData = (dic?["response"] as? [String: Any])?["items"] as? [[String: Any]] else {return}
//                var friends: [FriendItems] = []
//                for item in itemsData {
//                    guard let model = FriendItems(json: item)
//                    else {
//                        continue
//                    }
//                    friends.append(model)
//                }
//                self?.dataSource = friends
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else {return}
//                    self.realmManagerFriends.save(data: Array(friends))
//                    self.tableView.reloadData()
//                }
//            }
//            task.resume()
//        }
//
//    func convertToDictionary(data: Data) -> [String: Any]? {
//        do {
//                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//            } catch {
//                print(error.localizedDescription)
//            }
//        return nil
//    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.estimatedRowHeight = 50
    }


}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath) as! UITableViewCell
        let friends = dataSource?[indexPath.row]
        cell.textLabel?.text = friends?.first_name ?? "" + " " + friends!.last_name
       // let imageUrl = URL(string: friends?.photo_50! ?? "")
        //cell.imageView?.kf.setImage(with: imageUrl, placeholder: nil)
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(cellHeight)
//    }

}


//extension FriendsViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            self.friendsArray = self.savedFriendsArray
//        }
//        else {
//            self.friendsArray = self.friendsArray.filter({ friendsItem in
//                friendsItem.name.lowercased().contains(searchText.lowercased())
//            })
//        }
//        formArrayLetter()
//        self.tableView.reloadData()
//    }
//
//}

