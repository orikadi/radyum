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
    
     func getAllReviews(callback:@escaping ([Review]?)->Void){
        print("get all reviews called")
        //get the local last update date
        let lud = Review.getLastUpdateDate();
        
        //get the cloud updates since the local update date
        Model.modelFirebaseInstance.getAllReviews(since:lud) { (data) in
            //insert update to the local db
            var lud:Int64 = 0;
            for review in data!{
                review.addToDb()
                print("review's current last update date") //test
                if review.lastUpdate! > lud {lud = review.lastUpdate!}
            }
            if (data!.count == 0) {print("no reviews found")} //test
            //update the reviews local last update date
            Review.setLastUpdate(lastUpdated: lud)
            // get the complete restaurant list
            let finalData = Review.getAllReviewsFromDb()
            callback(finalData);
        }
    }
    
    func getAllReviewsByRestaurantID(resId:String,callback:@escaping ([Review]?)->Void){
        Model.modelFirebaseInstance.getAllReviewsByRestaurantID(resId:resId,callback: callback);
       }
    
    func getAllReviewsByUserEmail(userEmail:String,callback:@escaping ([Review]?)->Void){
    Model.modelFirebaseInstance.getAllReviewsByUserEmail(userEmail:userEmail,callback: callback);
       }
    
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


extension UIButton {
    func  applyDesign(){
        self.backgroundColor = UIColor.darkGray.withAlphaComponent(0.35);
        self.layer.cornerRadius = 7
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    
    }
}

extension UIButton {
    func  applyDesign1(){
        self.backgroundColor = UIColor.red.withAlphaComponent(0.5);
        self.layer.cornerRadius = 7
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    
    }
}

extension UILabel {
    func  applyDesign2(){
        self.backgroundColor = UIColor.red.withAlphaComponent(0.5);
        self.layer.cornerRadius = 7
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    
    }
}

extension UIImageView {
    func  applyDesign3(){
        self.backgroundColor = UIColor.red.withAlphaComponent(0.5);
        self.layer.cornerRadius = 7
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    
    }
}



