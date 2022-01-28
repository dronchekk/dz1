//
//  Array+Additions.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 08.01.2022.
//

import Foundation

extension Array {

    func itemAt(index: Int) -> Element? {
        let item = indices.contains(index) ? self[index] : nil
        return item
    }
}
