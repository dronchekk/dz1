//
//  LoadImageView.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 08.01.2022.
//

import UIKit
import Alamofire

class LoadImageView: UIView {

    var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    var imageUrl: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }

    init?(url text: String) {
        guard let url = URL(string: text) else {
            return nil
        }
        super.init(frame: .zero)

        // TODO: Продумать механизм работы с кэшированными данными

    }
}

private extension LoadImageView {

    func initialize() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
