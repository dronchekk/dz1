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
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.makeRequest()
        }
    }
}

private extension NewsViewController {

    func makeRequest() {
        PostService.shared.obtainAllNews { [weak self] (result) in
            var newDataSource: NewsDataSource = .init()
            switch result {
            case let .success(dataSource):
                guard let source = dataSource as? NewsDataSource else {break}
                newDataSource = source
            case .failure(_):
                break
            }
            DispatchQueue.main.async { [weak self] in
                self?.dataSource = newDataSource
                self?.tableView.reloadData()
            }
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

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 74.0
    }

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
        as? NewsHeaderView
        let section = dataSource.sectionModelList.itemAt(index: section)
        header?.titleLabel.text = section?.groupName
        header?.avatarImageView.imageUrl = section?.groupImageUrl
        header?.subtitleLabel.text = section?.groupSubname
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
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsTextTableViewCell.self), for: indexPath) as! NewsTextTableViewCell
            cell.titleLabel.text = section.itemText

            return cell
        case let .image(count: count):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsImageTableViewCell.self), for: indexPath) as! NewsImageTableViewCell
            

            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: NewsFooterView.self))
        as? NewsFooterView
        let section = dataSource.sectionModelList.itemAt(index: section)
//        footer?.button1.setTitle(<#T##title: String?##String?#>, for: <#T##UIControl.State#>)
        return footer
    }
}

extension NewsViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
}

