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
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var user:User?
    //TODO: add spinner to review table in user profile
    @IBOutlet weak var userNameTitle: UILabel!
//    @IBOutlet weak var numOfReviewsTitle: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var editPictureButton: UIButton!
    @IBOutlet weak var viewReviewbutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        user = Model.currentUser
        userNameTitle.text = user!.name

        if user!.avatar != ""{
            picture.kf.setImage(with: URL(string: user!.avatar!))
        }
        else{
            picture.kf.setImage(with: URL(string: "https://firebasestorage.googleapis.com/v0/b/radyum-4db50.appspot.com/o/defaultUserPic.png?alt=media&token=d4567663-98cd-4f68-a2ef-f5ce570ac3fa"))
        }
        logoutButton.applyDesign1()
        viewReviewbutton.applyDesign1()
        editPictureButton.applyDesign1()
          userNameTitle.applyDesign2()
    }
    
    @IBAction func editPicture(_ sender: Any) {
        spinner.isHidden = false
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true){self.spinner.isHidden = true}
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newPic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if(newPic != nil && newPic != self.picture.image){
            self.picture.image = newPic
            Model.modelFirebaseInstance.saveImage(image: self.picture.image!, kind: "user") { (url) in
                self.user?.avatar = url
                Model.modelFirebaseInstance.editUserPicUrl(url: url)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logout(_ sender: Any) {
        do{try Auth.auth().signOut()}
        catch{print("cant sign out")}
        Model.currentUser = nil
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "fromUserProfileToReviews" {
                  let vc:UserReviewsTableViewController = segue.destination as! UserReviewsTableViewController
                  vc.user = user
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
    
    @IBAction func toProfilePage(segue:UIStoryboardSegue){}
    
}

