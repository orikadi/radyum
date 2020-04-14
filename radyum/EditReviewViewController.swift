//
//  EditReviewViewController.swift
//  radyum
//
//  Created by admin on 13/04/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit

class EditReviewViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var review:Review?
    //TODO: buttons functionality, alert on done "are you sure"
    //when exiting back to display review, edit the display controller's review to this updated one?
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var reviewPicture: UIImageView!
    @IBOutlet weak var picSpinner: UIActivityIndicatorView!
    @IBOutlet weak var doneSpinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewText.text = review?.text
        picSpinner.isHidden = true
        doneSpinner.isHidden = true
        if(review?.picture != ""){
            reviewPicture.kf.setImage(with: URL(string: review!.picture))
        }
    }
    @IBAction func DoneAction(_ sender: Any) {
        performSegue(withIdentifier: "backToReviewPage", sender: self)

    }
    
    @IBAction func BackAction(_ sender: Any) {
        performSegue(withIdentifier: "backToReviewPage", sender: self)
    }
    
    @IBAction func EditPictureAction(_ sender: Any) {
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
