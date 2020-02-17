//
//  Review.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Review{
    //var id:String
    var user:User
    var text:String?
    var picture:String? //uimage?
    
    init (user:User, text:String?, picture: String?){
        self.user = user
        self.text = text
        self.picture = picture
    }
}
