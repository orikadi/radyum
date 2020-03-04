//
//  Review.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Review{
    //id needed?
    let id:String //document id?
    var user:User
    var restaurant:Restaurant
    var text:String?
    var picture:String?
    var lastUpdate: Int64?
    
    init (id:String, user:User, restaurant:Restaurant, text:String?, picture: String?){
        self.id = id
        self.user = user
        self.restaurant = restaurant
        self.text = text
        self.picture = picture
    }
}
