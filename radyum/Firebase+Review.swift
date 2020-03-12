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
        let userEmail = json["userEmail"] as! String
        let userName = json["userName"] as! String
        let resId = json["restaurantId"] as! String
        let resName = json["restaurantName"] as! String
        let text = json["text"] as! String
        let pic = json["picture"] as! String
        let ts = json["lastUpdate"] as! Timestamp
        self.init(id:id, userEmail:userEmail, userName:userName, resId:resId, resName:resName, text: text)
        picture = pic
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["userEmail"] = userEmail
        json["userName"] = userName
        json["resId"] = resId
        json["restaurantName"] = resName
        json["text"] = text
        json["picture"] = picture
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
