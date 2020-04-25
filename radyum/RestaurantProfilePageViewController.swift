	//
//  RestaurantProfilePageViewController.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class RestaurantProfilePageViewController: UIViewController {
    var restaurant:Restaurant?
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addReviewButton: UIButton!
    
    var backTo:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTitle.text = restaurant!.name
        addressTitle.text = restaurant!.address
        if restaurant!.picture != ""{
            Image.kf.setImage(with: URL(string: restaurant!.picture));
          }
        else{
            Image.kf.setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/radyum-4db50.appspot.com/o/defaultRestaurantPic.png?alt=media&token=8d76d6c9-1ff4-476e-8818-9cb2bf73d1c4"))
        }
        addReviewButton.applyDesign()
        backButton.applyDesign()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        if(backTo == "map"){
            performSegue(withIdentifier: "backToMap", sender: self)
        }
        if(backTo == "restaurants"){
            performSegue(withIdentifier: "backToRestaurants", sender: self)
        }
    }
     @IBAction func backToRestaurantProfile(segue:UIStoryboardSegue){}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddReview" {
            let vc:AddReviewViewController = segue.destination as! AddReviewViewController
            vc.restaurant = restaurant
        }
        if segue.identifier == "fromRestaurantToReviews" {
                 let vc:RestaurantReviewsTableViewController = segue.destination as! RestaurantReviewsTableViewController
                 vc.restaurant = restaurant
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
