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

    var sectionModelList: [NewsSectionModel] = []

    // MARK: Индекс последней успешно загруженной новости/секции
    var lastLoadSectionIndex: Int = .zero
}
