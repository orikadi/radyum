//
//  DisplayReviewViewController.swift
//  radyum
//
//  Created by Studio on 05/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class DisplayReviewViewController: UIViewController {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    var review:Review?
    var restaurantName:String?
    var returnTo:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = review?.userName
        restaurantNameLabel.text = restaurantName
        reviewTextLabel.text = review?.text
        if(review?.picture != ""){
            picture.kf.setImage(with: URL(string: review!.picture))
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        if(returnTo == "RestaurantReviewsTableViewController"){
            performSegue(withIdentifier: "backToRestaurantReview", sender: self)
        }
        if(returnTo == "UserReviewsTableViewController"){
            performSegue(withIdentifier: "backToUser", sender: self)
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
