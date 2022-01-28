//
//  VKFormatter.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey Rachitskiy on 20.01.2022.
//

import Foundation

class VKFormatter {

    static private let dateFormatter = DateFormatter()

    static func convertDateToString(timeIntervalSince1970: Double) -> String {
        dateFormatter.dateFormat = "MM-dd-yyyy HH.mm"
        let date = Date(timeIntervalSince1970: timeIntervalSince1970)
        
        return dateFormatter.string(from: date)
    }
}
