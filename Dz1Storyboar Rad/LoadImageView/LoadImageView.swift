//
//  LoadImageView.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 08.01.2022.
//

import UIKit
import Alamofire

class LoadImageView: UIView {

    let cacheManager: CacheFileManager = .init()

    var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    var imageUrl: String? {
        didSet {
            guard let urltext = imageUrl else {
                imageView.image = UIImage(named: "")
                return
            }
            if let imageData = cacheManager.getFile(url: urltext) {
                imageView.image = UIImage(data: imageData)
            } else if let url = URL.init(string: urltext) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async { [weak self] in
                            guard let image = UIImage.init(data: data), let id = image.pngData() else { return }

                            self?.imageView.image = UIImage.init(data: data)
                            let _ = try? self?.cacheManager.save(fileName: urltext, data: id)
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            self?.imageView.image = UIImage(named: "")
                        }
                    }
                }.resume()
            }
        }
    }



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
        self.imageUrl = text
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
