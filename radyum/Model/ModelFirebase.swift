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
    
    func saveImage(image:UIImage, callback:@escaping (String)->Void){
        let storageRef = Storage.storage().reference(forURL:
            "gs://radyum-4db50.appspot.com")
        let data = image.jpegData(compressionQuality: 0.5)
        let imageRef = storageRef.child("imageName")
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
    
    func editUserPicUrl(url:String){
        let db = Firestore.firestore()
        if(Model.currentUser?.avatar != nil){
        let storageRef = Storage.storage().reference(forURL:
            "gs://radyum-4db50.appspot.com").child(Model.currentUser!.avatar!).delete(completion: nil)
        }
        db.collection("users").document(Auth.auth().currentUser!.uid).updateData(["avatar":url])
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
