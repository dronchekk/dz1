//
//  Session.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 19.11.2021.
//

import Foundation

class Session {

//    private init () {}
    static let instance = Session()
    var token: String = "1"
    var userId: Int = 0
    var userlogin: String = ""

    init(token: String = "1",
         userId: Int = 0,
         userlogin: String = "") {
        self.token = token
        self.userId = userId
        self.userlogin = userlogin
    }
}
