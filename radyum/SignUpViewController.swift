//
//  SignUpViewController.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        emailText.attributedPlaceholder =
        NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
               
        passwordText.attributedPlaceholder =
        NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        userText.attributedPlaceholder =
        NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
               
        signUpButton.applyDesign1()
        backButton.applyDesign1()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        spinner.isHidden = false
        if (userText.text == nil) {
            let alert = UIAlertController(title: "WARNING", message: "Input a name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                //alert.dismiss(animated: true, completion: nil)
            }))
        }
        else {Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { user, error in
            if let x = error {
                let err = x as NSError
                switch err.code {
                case AuthErrorCode.invalidEmail.rawValue:
                    let alert = UIAlertController(title: "WARNING", message: "Invalid Email Address", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                        //alert.dismiss(animated: true, completion: nil)
                    }))
                    self.spinner.isHidden = true
                    self.present(alert, animated:true, completion:nil)
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    let alert = UIAlertController(title: "WARNING", message: "Account already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                        //alert.dismiss(animated: true, completion: nil)
                    }))
                    self.spinner.isHidden = true
                    self.present(alert, animated:true, completion:nil)
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    let alert = UIAlertController(title: "WARNING", message: "Account email already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                        //alert.dismiss(animated: true, completion: nil)
                    }))
                    self.spinner.isHidden = true
                    self.present(alert, animated:true, completion:nil)
                default:
                    self.spinner.isHidden = true
                    print("unknown error: \(err.localizedDescription)")
                }
            } else {
                //continue to app
                Model.modelFirebaseInstance.addUser(email: self.emailText.text!, name: self.userText.text!)
                self.spinner.isHidden = true
                self.performSegue(withIdentifier: "toLogin", sender: self)
            }
            }
        }
    }
    
    @IBAction func BackToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    
  
    
}
