//
//  Constants.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 22.10.2021.
//

import Foundation
import UIKit

public typealias AnyCompletion = (Result<Any, Error>)->()
public typealias VoidCompletion = (Result<Void, Error>)->()
let galleryCollectionCellNibName = "GalleryCollectionCell"
let cellHeight = 70
var loginUser = ""

extension UIColor {
    static let brandBlackC = UIColor.black.cgColor
    static let brandBlueC = UIColor.systemBlue.cgColor
    static let brandWhiteC = UIColor.white.cgColor
    static let brandBlack = UIColor.black
    static let brandWhite = UIColor.white
}

extension UIFont {
    static let brandTitle = UIFont.systemFont(ofSize: 16.0)
    static let brandSubtitle = UIFont.systemFont(ofSize: 14.0)
    static let brandButton = UIFont.systemFont(ofSize: 12.0)

}
