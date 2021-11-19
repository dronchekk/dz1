//
//  GalleryViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 22.10.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let reuseIdentifierGalleryCell = "reuseIdentifierGalleryCell"
    var photos = [UIImage]()
    var fullScreenView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate  = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: galleryCollectionCellNibName, bundle: nil), forCellWithReuseIdentifier: reuseIdentifierGalleryCell)
    }



}

