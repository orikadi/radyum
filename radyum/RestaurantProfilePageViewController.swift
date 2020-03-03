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
    var backTo:String = "a"
    //TODO: check if back button with navBar or if you can pop a view without a navBar!!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTitle.text = restaurant!.name
        addressTitle.text = restaurant!.address
        if restaurant!.picture != ""{
            Image.kf.setImage(with: URL(string: restaurant!.picture));
          }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
