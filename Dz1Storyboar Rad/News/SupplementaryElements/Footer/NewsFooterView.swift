//
//  NewsFooterView.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

class NewsFooterView: UITableViewHeaderFooterView {

    @IBOutlet private var wrapper: UIView!
    @IBOutlet private var staсkView: UIStackView!

    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var button4: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
    }
}

extension NewsFooterView {

    func setupViews() {
        button1 = UIButton(type: .custom)
        button1.setTitle("", for: .normal)
        button1.frame = CGRect(origin: .zero, size: CGSize(width: 45.0, height: 45.0))
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        button1.setImage(UIImage(named: "heart"), for: .normal)
        staсkView.addArrangedSubview(button1)


        button2 = UIButton(type: .custom)
        button2.frame = CGRect(origin: .zero, size: CGSize(width: 45.0, height: 45.0))
        button2.setTitle("", for: .normal)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        staсkView.addArrangedSubview(button2)

        button3 = UIButton(type: .custom)
        button3.frame = CGRect(origin: .zero, size: CGSize(width: 45.0, height: 45.0))
        button3.setTitle("", for: .normal)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        staсkView.addArrangedSubview(button3)

        button4 = UIButton(type: .custom)
        button4.frame = CGRect(origin: .zero, size: CGSize(width: 45.0, height: 45.0))
        button4.setTitle("", for: .normal)
        button4.translatesAutoresizingMaskIntoConstraints = false
        button4.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
        button4.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        staсkView.addArrangedSubview(button4)
    }
}
