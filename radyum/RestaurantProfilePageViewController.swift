	//
//  RestaurantProfilePageViewController.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class RestaurantProfilePageViewController: UIViewController {

    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var numOfReviewsTitle: UILabel!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var backButton: UIButton! //TODO: check if back button with navBar or if you can pop a view without a navBar!!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
