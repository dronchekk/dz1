//
//  GalleryViewController+CollectionDelegate.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 22.10.2021.
//

import UIKit

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showView(image: self.photos[indexPath.item])
    }







    
}
