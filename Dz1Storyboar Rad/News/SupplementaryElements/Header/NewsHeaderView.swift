//
//  NewsHeaderView.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit



class NewsHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var avatarImageView: LoadImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
}

private extension NewsHeaderView {

    func setupViews() {
        avatarImageView.imageView.layer.cornerRadius = avatarImageView.bounds.height / 2.0
        setupTitleLabel()
        setupSubtitleLabel()
    }

    func setupTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.text = "News"
        titleLabel.textColor = .brandBlack
        titleLabel.font = .brandTitle
    }

    func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 1
        subtitleLabel.text = "date"
        subtitleLabel.textColor = .gray.withAlphaComponent(0.75)
        subtitleLabel.font = .brandSubtitle
    }
}
