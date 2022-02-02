//
//  NewsTextTableViewCell.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

protocol NewsTextCellDelegate: AnyObject {

    func didTouchMoreButtonFor(cell: NewsTextTableViewCell, button: UIButton)
}

class NewsTextTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    let moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    weak var delegate: NewsTextCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}

private extension NewsTextTableViewCell {

    func setupView() {
        titleLabel.numberOfLines = 10

        setupMoreButton()
    }

    func setupMoreButton() {
        moreButton.setTitle("Show more", for: .normal)
        moreButton.setTitle("Show less", for: .selected)
        moreButton.setTitleColor(.blue, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)

        moreButton.addTarget(self, action: #selector(didTouchMoreButton(_:)), for: .touchUpInside)

        addSubview(moreButton)
        NSLayoutConstraint.activate([
            moreButton.centerYAnchor.constraint(equalTo: self.bottomAnchor, constant: -7.0),
            moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
    }

    @objc
    func didTouchMoreButton(_ button: UIButton) {
        button.isSelected.toggle()
        titleLabel.numberOfLines = button.isSelected ? 0 : 10

        delegate?.didTouchMoreButtonFor(cell: self, button: button)
    }
}
