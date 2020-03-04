//
//  Restaurant.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase

class Restaurant{
    let id:String //change to document id?
    var name:String	
    var address:String = "" //changed
    var geoPoint:GeoPoint? //added
    var picture:String = "" //changed
    var lastUpdate: Int64? //change to Timestamp type?
    var reviews:[Review]? //needed?
    
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


