//
//  NewsDataSource.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 08.01.2022.
//

import UIKit

struct NewsSectionModel {

    var groupImageUrl: String?
    var groupName: String = ""
    var groupSubname: String?

    var itemTypeList: [NewsItemType] = []
    var itemText: String?
    var itemImageUrlList: [String]?
}

class NewsDataSource {

    var groupList: [DetailGroup] = []
    var profilesList: [DetailProfiles] = []
    var itemsList: [PostItem] = []

    var sectionModelList: [NewsSectionModel] = []

    // MARK: Индекс последней успешно загруженной новости/секции
    var lastLoadSectionIndex: Int = .zero

    func convertToSectionModel() {
        for item in itemsList {
            let idGroup = abs(item.sourceId)
            guard let group = groupList.filter ({$0.id == idGroup}).first else {continue}
            let section = NewsSectionModel(groupImageUrl: group.photoUrl, groupName: group.name, groupSubname: VKFormatter.convertDateToString(timeIntervalSince1970: item.date), itemTypeList: [.text], itemText: item.text, itemImageUrlList: nil)
            sectionModelList.append(section)
        }
    }
}
