//
//  NewsViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!

    var dataSource = NewsDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        makeRequest()
    }
}

private extension NewsViewController {

    func makeRequest() {
        PostService.shared.obtainAllNews { [weak self] (result) in
            switch result {
            case let .success(dataSource):
                guard let source = dataSource as? NewsDataSource else {break}
                self?.dataSource = source
            case let .failure(error):
                break
            }
            self?.tableView.reloadData()
        }
    }


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
        return 49.0
    }
}

extension NewsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sectionModelList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.sectionModelList[section].itemTypeList.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: NewsHeaderView.self))

        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let section = dataSource.sectionModelList.itemAt(index: indexPath.section),
              let itemType = section.itemTypeList.itemAt(index: indexPath.item)
        else {
            return tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        }
        switch itemType {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTextTableViewCell.self), for: indexPath) as! NewsImageTableViewCell

            return cell
        case let .image(count: count):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsImageTableViewCell.self), for: indexPath) as! NewsImageTableViewCell
            

            return cell
        }
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

