//
//  AllGroupsViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 16.10.2021.
//

import UIKit
import Foundation
import Firebase

class AllGroupsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    let reuseIdentifierCustom = "reuseIdentifierCustom"
    var allGroupsArray = [Group]()
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    var userSelect = [FirebaseAllGroupsChoose]()
    private let ref = Database.database(url: "https://gbdzvkclient-default-rtdb.europe-west1.firebasedatabase.app").reference(withPath: "user")
    var selectedGroup: Group?

    func fillAllGroupsArray() {
        let group1 = Group(title: "Youtube", avatar: UIImage(named: "Allgroups1")!)
        let group2 = Group(title: "TikTok", avatar: UIImage(named: "Allgroups2")!)
        allGroupsArray.append(group1)
        allGroupsArray .append(group2)

    }

    class FirebaseAllGroupsChoose {
        let user: String
        let groupSelected: String
        let ref: DatabaseReference?

        init(user: String, groupSelected: String) {
            self.user = loginUser
            self.groupSelected = groupSelected
            self.ref = nil
        }

        init? (snapshot: DataSnapshot) {
            guard let value = snapshot.value as? [String: Any],
                  let user = value["loginUser"] as? String,
                let groupSelected = value["groupSelected"] as? String
            else {
                return nil
            }
            self.user = loginUser
            self.groupSelected = groupSelected
            self.ref = snapshot.ref
        }
        func toDict() -> [String: Any] {
            return [
                "loginUser": user,
                "groupSelected": groupSelected
            ]
    }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        fillAllGroupsArray()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self


    }

}

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroupsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: allGroupsArray[indexPath.row])
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedGroup = allGroupsArray[indexPath.row]
        performSegue(withIdentifier: fromAllGroupsToMyGroupsSegue, sender: nil)
        let select = FirebaseAllGroupsChoose.init(user: loginUser, groupSelected: selectedGroup?.title ?? "Error")
        let selectRef = self.ref.child(select.user.lowercased())
        selectRef.setValue(select.toDict())
        userSelect.append(select)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
}

extension AllGroupsViewController: CustomTableCellProtocol {
    func customTableCellLikeCounterIncrement(counter: Int) {
        print(String(counter))
    }

    func customTableCellLikeCounterDecrement(counter: Int) {
        print(String(counter))
    }


}
