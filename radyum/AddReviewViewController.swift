//
//  AddReviewViewController.swift
//  radyum
//
//  Created by Studio on 04/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class AddReviewViewController: UIViewController {

    var restaurant: Restaurant?
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet var backButton: UIView!
    
    //TODO: add picture button functionality, make picture appear in uiimageview
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantName.text = restaurant?.name
        // Do any additional setup after loading the view.
    }
    
    //backToRestaurantProfile
    @IBAction func addReview(_ sender: Any) {
        if reviewText.text == "" {
            let alert = UIAlertController(title: "ALERT", message: "Can't add a review without text", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                //alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated:true, completion:nil)
        }
        else {
            //TODO: yoav add URL to 'picture: "" ' below
            Model.modelFirebaseInstance.addReview(user: Model.currentUser!, restaurant: restaurant!, text: reviewText.text!, picture: "")
            performSegue(withIdentifier: "backToRestaurantProfile", sender: self)
        }
     }
    
    @IBAction func backToRestaurantPage(_ sender: Any) {
        performSegue(withIdentifier: "backToRestaurantProfile", sender: self)
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
