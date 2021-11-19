//
//  MyGroupsViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 16.10.2021.
//

import UIKit

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    var myGroupsArray = [Group]()


    func fillMyGroupsArray() {
        let group1 = Group(title: "Природа", avatar: UIImage(named: "Mygroups1")!)
        let group2 = Group(title: "Музыка", avatar: UIImage(named: "Mygroups2")!)
        myGroupsArray.append(group1)
        myGroupsArray.append(group2)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        fillMyGroupsArray()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func isItemAlreadyInArray(group: Group) -> Bool {
        myGroupsArray.contains { sourceGroup in
            sourceGroup.title == group.title
        }

    }



    @IBAction func unwindSegueToMyGroup(segue: UIStoryboardSegue) {
        if segue.identifier == fromAllGroupsToMyGroupsSegue,
           let sourceVC = segue.source as? AllGroupsViewController,
           let selectedGroup = sourceVC.selectedGroup as? Group
        {
            if isItemAlreadyInArray(group: selectedGroup){return }
            self.myGroupsArray.append(selectedGroup)
            tableView.reloadData()

        }
    }




}

extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myGroupsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        cell.configure(group: myGroupsArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }

}
