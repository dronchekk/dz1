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
        setupTitleLabel()
        setupSubtitleLabel()
    }

    func setupTitleLabel() {
        titleLabel.numberOfLines = 1
        titleLabel.text = "News"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
    }

    func setupSubtitleLabel() {
        subtitleLabel.numberOfLines = 1
        subtitleLabel.text = "date"
        subtitleLabel.textColor = .gray.withAlphaComponent(0.75)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
    }
}
