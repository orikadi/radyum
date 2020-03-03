//
//  ProfilePgeViewController.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ProfilePgeViewController: UIViewController {
    var user:User?
    @IBOutlet weak var userNameTitle: UILabel!
//    @IBOutlet weak var numOfReviewsTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        //let user = ModelFirebase.instance.getCurrentUser()
        user = Model.currentUser
        userNameTitle.text = user!.name
//        if user!.reviews != nil {
//            numOfReviewsTitle.text = String(user!.reviews!.count)
//        }
//        else {
//            numOfReviewsTitle.text = String(0)
//        }
        if user!.avatar != ""{
            picture.kf.setImage(with: URL(string: user!.avatar!));
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
}
