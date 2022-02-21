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

    var isCollapsed = true
}

class NewsDataSource {

    static let emptyDataKey = "next_from"
    static let loadingItemCount: Int = 50

    var itemsList: [PostItem] = []
    var groups: Set<DetailGroup> = []
    var profiles: Set<DetailProfiles> = []

    var sectionModelList: [NewsSectionModel] = []

    var isLoading = false

    var nextNewsId: String = emptyDataKey {
        willSet {
            guard newValue == Self.emptyDataKey else { return }
            itemsList.removeAll()
            lastItemCount = 0
        }
    }

    var addSectionIndexs: IndexSet? {
        return newSectionIndexSet
    }

    private var lastItemCount: Int = .zero
    private var newSectionIndexSet: IndexSet?

    func convertToSectionModel() {
        if lastItemCount == 0 {
            sectionModelList.removeAll()
        }

        guard lastItemCount < itemsList.count else { return }
        for index in lastItemCount ..< itemsList.count {
            let item = itemsList[index]
            let idGroup = abs(item.sourceId)
            guard let group = groups.filter ({$0.id == idGroup}).first else {continue}
            let section = NewsSectionModel(groupImageUrl: group.photoUrl, groupName: group.name, groupSubname: VKFormatter.convertDateToString(timeIntervalSince1970: item.date),
                                           itemTypeList: [.text],
                                           itemText: item.text,
                                           itemImageUrlList: nil)
            sectionModelList.append(section)
        }
        let last = lastItemCount
        lastItemCount += (itemsList.count - last)
        newSectionIndexSet = IndexSet(integersIn: (last..<lastItemCount))
    }
}
