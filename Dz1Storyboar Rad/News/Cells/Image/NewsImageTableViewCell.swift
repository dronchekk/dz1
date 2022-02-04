//
//  NewsImageTableViewCell.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

class NewsImageTableViewCell: UITableViewCell {

    var heightConstraint: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
}

private extension NewsImageTableViewCell {

    func setupView() {
        let constraint = NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50.0)
        NSLayoutConstraint.activate([constraint])
        heightConstraint = constraint
    }
}
