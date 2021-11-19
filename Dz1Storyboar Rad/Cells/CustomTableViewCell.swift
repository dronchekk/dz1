//
//  CustomTableViewCell.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 16.10.2021.
//

import UIKit

protocol CustomTableCellProtocol: AnyObject {
    func customTableCellLikeCounterIncrement(counter: Int)
    func customTableCellLikeCounterDecrement(counter: Int)
}


class CustomTableViewCell: UITableViewCell {


    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var likeView: LikeCounterView!

    weak var delegate: CustomTableCellProtocol?
    var completion: ((Friend) -> Void)?
    var friend: Friend?

    override func prepareForReuse() {
        avatarImageView.image = nil
        titleLabel.text = nil
        completion = nil
        friend = nil
    }

    func configure (friend: Friend, completion: ((Friend) -> Void)?) {
        self.completion = completion
        self.friend = friend
        avatarImageView.image = friend.avatar
        titleLabel.text = friend.name
    }

    func configure (group: Group){
        avatarImageView.image = group.avatar
        titleLabel.text = group.title
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        likeView.delegate = self
        avatarImageView.layer.cornerRadius = CGFloat (cellHeight / 2 - 8)
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.layer.borderWidth = 1
        backView.layer.cornerRadius = CGFloat (cellHeight / 2 - 4)
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 4, height: 4)
        backView.layer.shadowRadius = 4
        backView .layer.shadowOpacity = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func pressAvatarButton (_ sender: Any) {
        let scale = CGFloat(20)
        //let frame = avatarImageView.frame
        UIView.animate(withDuration: 2) { [weak self] in
            guard let self = self else {return}
//            self.avatarImageView.frame = CGRect(x: self.avatarImageView.frame.origin.x + scale / 2, y: self.avatarImageView.frame.origin.y + scale / 2, width: self.avatarImageView.frame.width - scale, height: self.avatarImageView.frame.height - scale)
            self.avatarImageView.frame = CGRect(x: self.avatarImageView.frame.origin.x - scale / 2, y: self.avatarImageView.frame.origin.y - scale / 2, width: self.avatarImageView.frame.width + scale, height: self.avatarImageView.frame.height + scale)
            } completion: { [weak self] isAllSeccessfully in
                guard let self = self else {return}
                if isAllSeccessfully,
                   let friend = self.friend
                {
                    self.completion?(friend)
                }
            }

        }

    }


extension CustomTableViewCell: LikeCounterProtocol {
    func likeCounterDecrement(counter: Int) {
        delegate?.customTableCellLikeCounterDecrement(counter: counter)
    }

    func likeCounterIncrement(counter: Int) {
        delegate?.customTableCellLikeCounterIncrement(counter: counter)
    }
}
