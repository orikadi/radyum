//
//  Restaurant.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation

class Restaurant{
    let id:String
    var name:String	
    var address:String = "" //changed
    var geoPoint:String = "" //added
    var picture:String = "" //changed
    var lastUpdate: Int64?
    
    init(id:String, name:String, address:String){
        self.id = id
        self.name = name
        self.address = address
    }
    
//    init(name:String, address:String){
//        self.name = name
//        self.address = address
//    }
}


