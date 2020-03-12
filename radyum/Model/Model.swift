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
    //TODO: ADD LOG OUT BUTTON IN USER PROFILE
    static let instance = Model()
    static let modelFirebaseInstance:ModelFirebase = ModelFirebase()
    static var currentUser:User?
    static var userId:String?
    
     func getAllRestaurants(callback:@escaping ([Restaurant]?)->Void){
        print("get all restaurants called")
        //get the local last update date
        let lud = Restaurant.getLastUpdateDate();
        
        //get the cloud updates since the local update date
        Model.modelFirebaseInstance.getAllRestaurants(since:lud) { (data) in
            //insert update to the local db
            var lud:Int64 = 0;
            for restaurant in data!{
                restaurant.addToDb()
                print("restaurant's current last update date") //test
                if restaurant.lastUpdate! > lud {lud = restaurant.lastUpdate!}
            }
            if (data!.count == 0) {print("no restaurants found")} //test
            //update the restaurants local last update date
            Restaurant.setLastUpdate(lastUpdated: lud)
            // get the complete restaurant list
            let finalData = Restaurant.getAllRestaurantsFromDb()
            callback(finalData);
        }
    }
    func getAllReviewsByRestaurantID(resId:String,callback:@escaping ([Review]?)->Void){
        Model.modelFirebaseInstance.getAllReviewsByRestaurantID(resId:resId,callback: callback);
       }
//     func getAllReviews(callback:@escaping ([Review]?)->Void){
//        print("get all reviews called")
//        //get the local last update date
//        let lud = Review.getLastUpdateDate();
//        //get the cloud updates since the local update date
//        Model.modelFirebaseInstance.getAllRestaurants(since:lud) { (data) in
//            //insert update to the local db
//            var lud:Int64 = 0;
//            for restaurant in data!{
//                restaurant.addToDb()
//                print("restaurant's current last update date") //test
//                if restaurant.lastUpdate! > lud {lud = restaurant.lastUpdate!}
//            }
//            if (data!.count == 0) {print("no restaurants found")} //test
//            //update the restaurants local last update date
//            Restaurant.setLastUpdate(lastUpdated: lud)
//            // get the complete restaurant list
//            let finalData = Restaurant.getAllRestaurantsFromDb()
//            callback(finalData);
//        }
//    }
}
    
    class ModelEvents{
        static let RestaurantDataEvent = EventNotificationBase(eventName: "com.radyum.RestaurantDataEvent")
        static let ReviewDataEvent = EventNotificationBase(eventName: "com.radyum.ReviewDataEvent")
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


