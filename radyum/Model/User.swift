//
//  Users.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class User{
    var email:String
    var name:String
    var avatar:String?
    var reviews:[Review]? //needed?
    
    init(email:String) {
        self.email = email
        self.name = ""
        self.reviews = nil
        self.avatar = ""
    }
    
    init(email:String, name:String, reviews:[Review], avatar:String) {
        self.email = email
        self.name = name
        self.reviews = reviews
        self.avatar = avatar
    }

}
