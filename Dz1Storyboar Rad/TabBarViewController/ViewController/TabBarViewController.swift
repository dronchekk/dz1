//
//  TabBarViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension TabBarViewController {

    func setupViews() {
        tabBar.isHidden = false
        var tabBarControllerList: [UIViewController] = []

        let mainSt = UIStoryboard(name: "Main", bundle: nil)

        let groupViewController = mainSt.instantiateViewController(withIdentifier: String(describing: MyGroupsViewController.self))
        let groupNavVC = UINavigationController(rootViewController: groupViewController)
        groupNavVC.tabBarItem.title = "Группы"
        tabBarControllerList.append(groupNavVC)

        let friendsViewController = mainSt.instantiateViewController(withIdentifier: String(describing: FriendsViewController.self))
        let friendsNavVC = UINavigationController(rootViewController: friendsViewController)
        friendsNavVC.tabBarItem.title = "Друзья"
        tabBarControllerList.append(friendsNavVC)

        let newsSt = UIStoryboard(name: "NewsStoryboard", bundle: nil)
        let newsViewController = newsSt.instantiateViewController(withIdentifier: String(describing: NewsViewController.self))
        let newsNavVC = UINavigationController(rootViewController: newsViewController)
        newsNavVC.tabBarItem.title = "Новости"
        tabBarControllerList.append(newsNavVC)

        viewControllers = tabBarControllerList
        selectedIndex = 0

    }
}
