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

    private var refreshControl: UIRefreshControl = {
        return UIRefreshControl(frame: .zero)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        prepareData()
    }
}

private extension NewsViewController {

    func prepareData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.makeRequest()
        }
    }

    func makeRequest() {
        dataSource.isLoading = true
        PostService.shared.obtainAllNews(dataSource: dataSource) { (_) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.dataSource.isLoading = false
//                self.tableView.reloadData()

                guard let newSections = self.dataSource.addSectionIndexs else { return }
                self.tableView.insertSections(newSections, with: .fade)
                self.refreshControl.endRefreshing()
            }
        }
    }


    func setupView() {
        setupRefreshControl()
        setupTableView()
    }

    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc
    func handleRefreshControl() {
        dataSource.nextNewsId = NewsDataSource.emptyDataKey
        prepareData()
    }

    func setupTableView() {
        tableView.estimatedRowHeight = 50.0
        tableView.estimatedSectionHeaderHeight = 74.0
        tableView.estimatedSectionFooterHeight = 40.0
        tableView.refreshControl = refreshControl

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
        tableView.prefetchDataSource = self
    }
}

extension NewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 74.0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
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
            cell.titleLabel.numberOfLines = section.isCollapsed ? 10 : 0
            cell.moreButton.isSelected = !section.isCollapsed
            cell.delegate = self

            return cell

        case let .image(count: count):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsImageTableViewCell.self), for: indexPath) as! NewsImageTableViewCell
            

            return cell
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let textCell = cell as? NewsTextTableViewCell {
            textCell.moreButton.isHidden = cell.bounds.height < 200.0
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
        guard let maxSection = indexPaths.map({ $0.section }).max(),
              maxSection > tableView.numberOfSections - 4,
              !dataSource.isLoading
        else { return }
        prepareData()
        
        
    }
}

extension NewsViewController: NewsTextCellDelegate {

    func didTouchMoreButtonFor(cell: NewsTextTableViewCell, button: UIButton) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        dataSource.sectionModelList[indexPath.section].isCollapsed = !button.isSelected
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet([indexPath.section]), with: .fade)
        tableView.endUpdates()
    }
}

