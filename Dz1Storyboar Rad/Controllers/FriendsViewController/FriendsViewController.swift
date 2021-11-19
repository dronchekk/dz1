//
//  FriendsViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 16.10.2021.
//

import UIKit

class FriendsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromFriendsToGallerySegue = "fromFriendsToGallery"
    var friendsArray = [Friend]()
    var savedFriendsArray = [Friend]()
    var arrayLetter = [String]()

    //заголовок первых букв
    func arrayLetter(sourceArray: [Friend]) -> [String] {
        var resultArray = [String]()

        for item in sourceArray {
            let nameLetter = String(item.name.prefix(1))
            if !resultArray.contains(nameLetter.lowercased()) {
                resultArray.append(nameLetter.lowercased())
            }
        }
        return resultArray.sorted { firstItem, secondItem in
            firstItem < secondItem
        }
    }

    func formArrayLetter() {
        self.arrayLetter = arrayLetter(sourceArray: self.friendsArray)
    }


    //маленькие массивчики под первые буквы
    func arrayByLetter(sourceArray: [Friend], letter: String) -> [Friend] {
        var resultArray = [Friend]()
        for item in sourceArray {
            let nameLetter = String(item.name.prefix(1)).lowercased()
            if nameLetter == letter.lowercased() {
                resultArray.append(item)
            }
    }
        return resultArray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fillFriendsArray()
        formArrayLetter()
        savedFriendsArray = friendsArray
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToGallerySegue,
           // let sourceVC = segue.source as? FriendsViewController,
            let destinationVC = segue.destination as? GalleryViewController,
            let friend = sender as? Friend {
            destinationVC.photos = friend.photos
        }
    }
}

extension FriendsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.friendsArray = self.savedFriendsArray
        }
        else {
            self.friendsArray = self.friendsArray.filter({ friendsItem in
                friendsItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        formArrayLetter()
        self.tableView.reloadData()
    }

}

