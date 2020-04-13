//
//  EditReviewViewController.swift
//  radyum
//
//  Created by admin on 13/04/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class EditReviewViewController: UIViewController {
    var review:Review?
    //TODO: buttons functionality, alert on done "are you sure"
    //when exiting back to display review, edit the display controller's review to this updated one?
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var reviewPicture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewText.text = review?.text
        if(review?.picture != ""){
            reviewPicture.kf.setImage(with: URL(string: review!.picture))
        }
    }
    


}
