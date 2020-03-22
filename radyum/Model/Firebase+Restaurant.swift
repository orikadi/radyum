
//  Firebase+Restaurant.swift
//  radyum
//
//  Created by Studio on 01/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase
extension Restaurant{
    convenience init(json:[String:Any]){
        let id = json["id"] as! String
        let name = json["name"] as! String
        let address = json["address"] as! String
        self.init(id:id,name:name,address:address)
        geoPoint = json["geopoint"] as! GeoPoint
        picture = json["picture"] as! String
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = id
        json["name"] = name
        json["picture"] = picture
        json["address"] = address
        json["geopoint"] = geoPoint
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
