//
//  Model.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase

class Model{
    
    static let instance = Model()
    //var modelFirebase:ModelFirebase = ModelFirebase()
    static let modelFirebaseInstance:ModelFirebase = ModelFirebase()
    
     func getAllRestaurants(callback:@escaping ([Restaurant]?)->Void){
        
        //get the local last update date
        let lud = Restaurant.getLastUpdateDate();
        
        //get the cloud updates since the local update date
        Model.modelFirebaseInstance.getAllRestaurants(since:lud) { (data) in
            //insert update to the local db
            var lud:Int64 = 0;
            for student in data!{
                student.addToDb()
                if student.lastUpdate! > lud {lud = student.lastUpdate!}
            }
            //update the restaurants local last update date
            Restaurant.setLastUpdate(lastUpdated: lud)
            // get the complete student list
            let finalData = Restaurant.getAllRestaurantsFromDb()
            callback(finalData);
        }
    }
}
    
    class ModelEvents{
        static let RestaurantDataEvent = EventNotificationBase(eventName: "com.radyum.RestaurantDataEvent")
        
        private init(){}
    }
    
    class EventNotificationBase{
        let eventName:String;
        
        init(eventName:String){
            self.eventName = eventName;
        }
        
        func observe(callback:@escaping ()->Void){
            NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                                   object: nil, queue: nil) { (data) in
                                                    callback();
            }
        }
        
        func post(){
            NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                            object: self,
                                            userInfo: nil);
        }
    }


