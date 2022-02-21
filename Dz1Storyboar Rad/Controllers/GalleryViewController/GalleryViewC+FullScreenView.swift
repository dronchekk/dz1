//
//  GalleryViewC+FullScreenView.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 05.11.2021.
//

import UIKit

extension GalleryViewController {


    func showView(image: UIImage) {
        if fullScreenView == nil {
            fullScreenView = UIView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        }

        fullScreenView!.backgroundColor = .brandBlack
        self.view.addSubview(fullScreenView!)

        let imageView = UIImageView(image: image)
        fullScreenView?.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: fullScreenView!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: fullScreenView!.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: fullScreenView!.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: fullScreenView!.heightAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit


        let closeButton = UIButton(frame: CGRect(x: fullScreenView!.bounds.width - 40, y: 0, width: 40, height: 40))
        closeButton.tintColor = .brandWhite
        closeButton.addAction(UIAction(handler: { [weak self] _ in
            self?.fullScreenView!.removeFromSuperview()
        }), for: .touchUpInside)
        closeButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        fullScreenView?.addSubview(closeButton)
    }




}
