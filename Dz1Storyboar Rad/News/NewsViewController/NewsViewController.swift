//
//  NewsViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension NewsViewController {

    func setupView() {
        setupTableView()
    }

    func setupTableView() {
        tableView.estimatedRowHeight = 100.0
        tableView.estimatedSectionHeaderHeight = 74.0
        tableView.estimatedSectionFooterHeight = 50.0

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(nib: NewsTextTableViewCell.self)
        tableView.register(nib: NewsImageTableViewCell.self)
        tableView.register(UINib(nibName: String(describing: NewsFooterView.self),
                                 bundle: nil),
                           forHeaderFooterViewReuseIdentifier: String(describing: NewsFooterView.self))
        tableView.register(UINib(nibName: String(describing: NewsHeaderView.self),
                                 bundle: nil),
                           forHeaderFooterViewReuseIdentifier: String(describing: NewsHeaderView.self))

        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 69.0
    }
}

extension NewsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: NewsHeaderView.self))

        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: NewsFooterView.self))

        return footer
    }
}

extension NewsViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
}

