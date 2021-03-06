//
//  ModelFirebase.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    
    //adds new user to firebase
    func addUser(email:String, name: String) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        db.collection("users").document(userId!).setData([
            "email": email,
            "name": name,
            "avatar": ""
        ]) { err in
            if let err = err {
                print("Error adding user document: \(err)")
            }
        }
    }
    
    //gets current user from firebase
    func getCurrentUser()->User? {
        let userId = Auth.auth().currentUser?.uid
        let userEmail = Auth.auth().currentUser?.email
        var user = User(email: userEmail!)
        let db = Firestore.firestore()
        db.collection("users").document(userId!).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                user.name = data!["name"] as! String
                user.avatar = data!["avatar"] as! String
            } else {
                print("Current user document does not exist")
            }
        }
        return user
    }
    
    //delete??
    func getUserByEmail(userEmail:String, callback:@escaping (User)->Void) {
    
    
    }
    
    func getAllRestaurants(since:Int64, callback: @escaping ([Restaurant]?)->Void){
         let db = Firestore.firestore()
         db.collection("restaurants").order(by: "lastUpdate").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
                 callback(nil);
             } else {
                 var data = [Restaurant]();
                 for document in querySnapshot!.documents {
                     if let ts = document.data()["lastUpdate"] as? Timestamp{
                         let tsDate = ts.dateValue();
                         print("\(tsDate)");
                         let tsDouble = tsDate.timeIntervalSince1970;
                         print("\(tsDouble)");

                     }
                    print(document.data())
                    data.append(Restaurant(json: document.data()));
                 }
                 callback(data);
             }
         };
     }
    func getAllReviews(since:Int64, callback: @escaping ([Review]?)->Void){
          let db = Firestore.firestore()
          db.collection("reviews").order(by: "lastUpdate").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
                  callback(nil);
              } else {
                  var data = [Review]();
                  for document in querySnapshot!.documents {
                      if let ts = document.data()["lastUpdate"] as? Timestamp{
                          let tsDate = ts.dateValue();
                          print("\(tsDate)");
                          let tsDouble = tsDate.timeIntervalSince1970;
                          print("\(tsDouble)");

                      }
                     print(document.data())
                     data.append(Review(json: document.data()));
                  }
                  callback(data);
              }
          };
      }
    
    func saveImage(image:UIImage, kind:String, callback:@escaping (String)->Void){
        let storageRef = Storage.storage().reference(forURL:
            "gs://radyum-4db50.appspot.com")
        let data = image.jpegData(compressionQuality: 0.5)
        let name = kind + "-" + (getCurrentUser()?.email)! + getTime()
        let imageRef = storageRef.child(name)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
    
    func getTime()->String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    func editUserPicUrl(url:String){
        let db = Firestore.firestore()
        db.collection("users").document(Model.userId!).updateData(["avatar":url])
    }
    
    
    func addReview(user:User, restaurant:Restaurant, text:String, picture:String?) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
                ref = db.collection("reviews").addDocument(data: [
                    "userEmail": user.email,
                    "restaurantId": restaurant.id,
                    "userName": user.name,
                    "restaurantName": restaurant.name,
                    "text":text,
                    "picture":picture,
                    "lastUpdate": FieldValue.serverTimestamp()
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID\(ref!.documentID)")
                    }
                }
        ref?.setData((["id": ref!.documentID]),merge: true)
        ModelEvents.ReviewDataEvent.post()
    }
    
    func EditReview(review:Review, text:String, picture:String) {
        let db = Firestore.firestore()
    db.collection("reviews").document(review.id!).setData((["text":text, "picture":picture, "lastUpdate":Timestamp()]), merge: true)
        Review.updateReviewOnSql(review: review)
        ModelEvents.ReviewDataEvent.post()
    }
    
    func DeleteReview(review:Review) {
        let db = Firestore.firestore()
        db.collection("reviews").document(review.id!).delete()
        Review.deleteReviewOnSql(review: review)
        ModelEvents.ReviewDataEvent.post()
    }
    
    func getAllReviewsByRestaurantID(resId: String ,callback: @escaping ([Review]?)->Void){
        let db = Firestore.firestore();
        db.collection("reviews").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)");
                callback(nil);
            }else{
                var data = [Review]();
                for document in querySnapshot!.documents {
                    data.append(Review(json: document.data()));
                }
                var filteredPosts:[Review] = [Review]()
                for item in data {
                    if(resId == item.resId){
                        filteredPosts.append(item)
                    }
                }
                callback(filteredPosts);
            }
        }
    }
    
    func getAllReviewsByUserEmail(userEmail: String ,callback: @escaping ([Review]?)->Void){
        let db = Firestore.firestore();
        db.collection("reviews").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)");
                callback(nil);
            }else{
                var data = [Review]();
                for document in querySnapshot!.documents {
                    data.append(Review(json: document.data()));
                }
                var filteredPosts:[Review] = [Review]()
                for item in data {
                    if(userEmail == item.userEmail){
                        filteredPosts.append(item)
                    }
                }
                callback(filteredPosts);
            }
        }
    }
    
    
    
    //add a restaurant to firebase
//    func addRestaurant(email:String, name: String) {
//        let db = Firestore.firestore()
//        let restId = Auth.auth()
//        db.collection("users").document(userId!).setData([
//            "email": email,
//            "name": name,
//            "avatar": ""
//        ]) { err in
//            if let err = err {
//                print("Error adding user document: \(err)")
//            }
//        }
//    }
}
