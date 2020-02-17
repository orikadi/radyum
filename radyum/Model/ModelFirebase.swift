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
    
    static let instance = ModelFirebase()
    
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
                print("Document does not exist")
            }
        }
        return user
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
