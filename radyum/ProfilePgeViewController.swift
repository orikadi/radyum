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
    @IBOutlet weak var numOfReviewsTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //TODO: add tabbarcontroller and add a prepare function for profile segue, so you can populate the user var before entering the profile
        
        //let user = ModelFirebase.instance.getCurrentUser()
        let user = Model.modelFirebaseInstance.getCurrentUser()
//        userNameTitle.text = user!.name
//        numOfReviewsTitle.text = String(user!.numOfReviews!)
//        if user!.avatar != ""{
//            picture.kf.setImage(with: URL(string: user!.avatar!));
//        }
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
