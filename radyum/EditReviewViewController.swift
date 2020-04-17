//
//  EditReviewViewController.swift
//  radyum
//
//  Created by admin on 13/04/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class EditReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var review:Review?
    //maybe add "are you sure" alert?
    //yoav todo:
    //DoneAction - put the picture url into the parameter
    //after done the returned page is also updated
    //delete button and segue (delete should return you to the page before the display review since its deleted)
    //spinners wherever needed
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var reviewPicture: UIImageView!
    @IBOutlet weak var returnSpinner: UIActivityIndicatorView!
    @IBOutlet weak var picSpinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnSpinner.isHidden = true
        picSpinner.isHidden = true
        reviewText.text = review?.text
        if(review?.picture != ""){
            reviewPicture.kf.setImage(with: URL(string: review!.picture))
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        performSegue(withIdentifier: "backToDisplayReview", sender: self)
    }
    
    @IBAction func DoneAction(_ sender: Any) {
        Model.modelFirebaseInstance.EditReview(review: review!, text: reviewText.text!, picture: "123")
        performSegue(withIdentifier: "backToDisplayReview", sender: self)
    }
    @IBAction func editPicture(_ sender: Any) {
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
        self.reviewPicture.image = newPic
        dismiss(animated: true, completion: nil)
    }

    

}
