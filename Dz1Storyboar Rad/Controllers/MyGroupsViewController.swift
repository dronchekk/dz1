//
//  MyGroupsViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 16.10.2021.
//

import UIKit
import SwiftyJSON
import Kingfisher
import RealmSwift

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var dataSource: [GroupItems] = []
    let url = URL(string: "http://api.vk.com/method/groups.get?extended=1&access_token=\(Session.instance.token)&v=5.131")
    let reuseIdentifierCustom = "reuseIdentifierCustom"
//    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
//    var myGroupsArray = [Group]()


//    func fillMyGroupsArray() {
//        let group1 = Group(title: "Природа", avatar: UIImage(named: "Mygroups1")!)
//        let group2 = Group(title: "Музыка", avatar: UIImage(named: "Mygroups2")!)
//        myGroupsArray.append(group1)
//        myGroupsArray.append(group2)
//    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequest()
        configureTableView()
//        fillMyGroupsArray()
//        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
    }

    func makeRequest() {

            let task = URLSession.shared.dataTask(with: url!) { [weak self] data, response, error in
                guard let data = data else { return }
                let dic = self?.convertToDictionary(data: data)
                guard let itemsData = (dic?["response"] as? [String: Any])?["items"] as? [[String: Any]] else {return}
                var groups: [GroupItems] = []
                for item in itemsData {
                    guard let model = GroupItems(json: item)
                    else {
                        continue
                    }
                    groups.append(model)
                }
                self?.dataSource = groups
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.tableView.reloadData()
                }
//                do {
//                    let groups = try JSONDecoder().decode([Items].self, from: data)
//                    self?.dataSource = groups
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                } catch(let error) {

//                    print(error)
//                }
            }
            task.resume()
        }

    func convertToDictionary(data: Data) -> [String: Any]? {
        do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.estimatedRowHeight = 50
    }

//    func isItemAlreadyInArray(group: Group) -> Bool {
//            myGroupsArray.contains { sourceGroup in
//            sourceGroup.title == group.title
//        }
//
//    }



//    @IBAction func unwindSegueToMyGroup(segue: UIStoryboardSegue) {
//        if segue.identifier == fromAllGroupsToMyGroupsSegue,
//           let sourceVC = segue.source as? AllGroupsViewController,
//           let selectedGroup = sourceVC.selectedGroup as? Group
//        {
//            if isItemAlreadyInArray(group: selectedGroup){return }
//            self.myGroupsArray.append(selectedGroup)
//            tableView.reloadData()
//
//        }
//    }




}



extension MyGroupsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath) as! UITableViewCell
        let group = dataSource[indexPath.row]
        cell.textLabel?.text = group.name
        let imageUrl = URL(string: group.photo_50!)
        cell.imageView?.kf.setImage(with: imageUrl, placeholder: nil)
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(cellHeight)
//    }

}
