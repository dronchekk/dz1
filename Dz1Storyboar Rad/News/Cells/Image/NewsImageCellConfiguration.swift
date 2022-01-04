//
//  NewsImageCellConfiguration.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

struct NewsImageCellModel {

    var imageData: Data?
    var size: CGSize = .zero
}

class NewsImageCellConfiguration {

    static func setup(cell: NewsImageTableViewCell, mode list: [NewsImageCellModel]?) {
        var imageList: [UIImageView] = []

        for model in list ?? [] {
            guard let data = model.imageData else { continue }
            let image = UIImageView(image: UIImage(data: data))
            imageList.append(image)
        }
        // TODO: Местоположение UIImageView зависит от контента (UIImage)
        switch imageList.count {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4...999:
            break
        default:
            break
        }
    }
}
