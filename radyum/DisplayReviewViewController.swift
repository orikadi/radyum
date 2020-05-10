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
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bgColor: UILabel!
    @IBOutlet weak var bgColor2: UILabel!
    var review:Review?
    var restaurantName:String?
    var returnTo:String?
    @IBOutlet weak var theBackButton1: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.isHidden = true
        if (review?.userEmail == Model.currentUser?.email) {
            editButton.isHidden = false
        }
        userNameLabel.text = review?.userName
        restaurantNameLabel.text = restaurantName
        reviewTextLabel.text = review?.text
        if(review?.picture != ""){
            picture.kf.setImage(with: URL(string: review!.picture))
        }
        editButton.applyDesign1()
        bgColor.applyDesign2()
        reviewTextLabel.applyDesign2()
        picture.applyDesign3()
        theBackButton1.applyDesign1()
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        if(returnTo == "RestaurantReviewsTableViewController"){
            performSegue(withIdentifier: "backToRestaurantReview", sender: self)
        }
        if(returnTo == "UserReviewsTableViewController"){
            performSegue(withIdentifier: "backToUser", sender: self)
        }
        if(returnTo == "FeedPageTableViewController"){
            performSegue(withIdentifier: "backToFeed", sender: self)
        }
    }
    @IBAction func editAction(_ sender: Any) {
        performSegue(withIdentifier: "toEditReview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditReview" {
            let vc:EditReviewViewController = segue.destination as! EditReviewViewController
            vc.review = review
            vc.backTo = returnTo!
            //self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backToDisplayReview(segue:UIStoryboardSegue){}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


