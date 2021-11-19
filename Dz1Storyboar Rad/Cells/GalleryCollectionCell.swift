//
//  GalleryCollectionCell.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 22.10.2021.
//

import UIKit

class GalleryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var likeCounter: UILabel!
 
    
    var likeEnable = false
    var counter = 0

    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        likeEnable = false
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }


    func configure (image: UIImage) {
        photoImageView.image = image
    }

    func animateHeartButton () {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0.1
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.heartButton.layer.add(animation, forKey: nil)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func pressHeartButton(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        if likeEnable {
            animateHeartButton()
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            counter -= 1
            likeCounter.text = String(counter)

        }
        else {
            animateHeartButton()
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            counter += 1
            likeCounter.text = String(counter)
        }
        likeEnable = !likeEnable
    }



}
