//
//  GalleryViewController+FlowLayout.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 22.10.2021.
//

import UIKit

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let whitespace = CGFloat(1)
        let lineCountCell = CGFloat(2)
        let cellWidth = collectionViewWidth / lineCountCell - whitespace

        return CGSize(width: cellWidth, height: cellWidth)
    }
}
