//
//  UITableView+Additions.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 02.01.2022.
//

import UIKit

public extension UITableView {
    func register(nib: AnyClass, bundleEndpoint: String? = nil) {
        register(UINib(nibName: String(describing: nib), bundle: nil),
           forCellReuseIdentifier: String(describing: nib))
     }
}



