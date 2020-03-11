//
//  AddReviewViewController.swift
//  radyum
//
//  Created by Studio on 04/03/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class AddReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var returnSpinner: UIActivityIndicatorView!
    @IBOutlet weak var picSpinner: UIActivityIndicatorView!
    
    var restaurant: Restaurant?
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet var backButton: UIView!
    var picUrl:String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picSpinner.isHidden = true
        returnSpinner.isHidden = true
        restaurantName.text = restaurant?.name
        // Do any additional setup after loading the view.
    }
    
    //backToRestaurantProfile
    @IBAction func addReview(_ sender: Any) {
        returnSpinner.isHidden = false
        if reviewText.text == "" {
            let alert = UIAlertController(title: "ALERT", message: "Can't add a review without text", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                //alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated:true, completion:nil)
        }
        else {
            if(picture.image != nil){
                Model.modelFirebaseInstance.saveImage(image: self.picture.image!, kind: "review") { (url) in
                self.picUrl = url
                Model.modelFirebaseInstance.addReview(user: Model.currentUser!, restaurant: self.restaurant!, text: self.reviewText.text!, picture: self.picUrl)
                self.performSegue(withIdentifier: "backToRestaurantProfile", sender: self)
                }
            }
            else{
                picUrl = ""
                Model.modelFirebaseInstance.addReview(user: Model.currentUser!, restaurant: self.restaurant!, text: self.reviewText.text!, picture: self.picUrl)
                self.performSegue(withIdentifier: "backToRestaurantProfile", sender: self)
            }
        }
     }
    
    @IBAction func addPicture(_ sender: Any) {
        picSpinner.isHidden = false
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true){self.picSpinner.isHidden = true}
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newPic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.picture.image = newPic
        dismiss(animated: true, completion: nil)
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
