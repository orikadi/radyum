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

class ProfilePgeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var user:User?
    //TODO: add spinner to review table in user profile
    @IBOutlet weak var userNameTitle: UILabel!
//    @IBOutlet weak var numOfReviewsTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var editPictureButton: UIButton!
    
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
    
    @IBAction func editPicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newPic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if(newPic != nil && newPic != self.picture.image){
            self.picture.image = newPic
            Model.modelFirebaseInstance.saveImage(image: self.picture.image!) { (url) in
                self.user?.avatar = url
                Model.modelFirebaseInstance.editUserPicUrl(url: url)
            }
        }
        dismiss(animated: true, completion: nil)
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
