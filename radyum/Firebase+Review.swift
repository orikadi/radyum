//
//  Firebase+Review.swift
//  
//
//  Created by Studio on 04/03/2020.
//

import Foundation
import Firebase

extension Review{
    convenience init(json:[String:Any]){
        let id = json["id"] as! String
        let user = json["user"] as! User
        let restaurant = json["restaurant"] as! Restaurant
        let text = json["text"] as! String
        let picture = json["picture"] as! String
        let ts = json["lastUpdate"] as! Timestamp
        self.init(id:id, user:user, restaurant:restaurant, text: text, picture:picture)
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["user"] = user
        json["restaurant"] = restaurant
        json["text"] = text
        json["picture"] = picture
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
