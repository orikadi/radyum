//
//  Review.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Review{
    let id:String?
    var userEmail:String
    var userName:String
    var resId:String
    var text:String
    var picture:String = ""
    var lastUpdate: Int64?
    
    init (userEmail:String, resId:String, text:String){
        id = ""
        self.userEmail = userEmail
        self.userName = ""
        self.resId = resId
        self.text = text
        }
    init (id:String, userEmail:String, userName:String, resId:String, text:String){
        self.id = id
        self.userEmail = userEmail
        self.userName = userName
        self.resId = resId
        self.text = text
    }
}
