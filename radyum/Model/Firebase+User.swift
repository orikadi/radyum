//
//  Firebase+User.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase

extension User{
    convenience init(json:[String:Any]){
        let email = json["email"] as! String
        self.init(email:email)
        name = json["name"] as! String
        avatar = json["avatar"] as? String
        //reviews = json["reviews"] as? [Review]
        //let ts = json["lastUpdate"] as! Timestamp
        //lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["email"] = email
        json["name"] = name
        json["avatar"] = avatar
        //json["reviews"] = reviews
        //json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
