//
//  LoginViewController.swift
//  radyum
//
//  Created by Studio on 21/01/2020.
//  Copyright © 2020 Studio. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true

        emailText.attributedPlaceholder =
        NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        passwordText.attributedPlaceholder =
        NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        loginButton.applyDesign1()
        signUpButton.applyDesign1()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        spinner.isHidden = false
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user,error) in
            if error != nil {   
                let alert = UIAlertController(title: "WARNING", message: "Wrong credentials", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                    //alert.dismiss(animated: true, completion: nil)
                }))
                self.spinner.isHidden = true
                self.present(alert, animated:true, completion:nil)
            } else {
                self.spinner.isHidden = true
                self.performSegue(withIdentifier: "fromLoginToTabBar", sender: self)
            }
        })
        
        
  
 
    }
    
    @IBAction func toLogin(segue:UIStoryboardSegue){
        if(segue.identifier == "logoutSegue"){
            emailText.text = ""
            passwordText.text = ""
        }
    }
   
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "fromLoginToTabBar") {
            Model.currentUser = Model.modelFirebaseInstance.getCurrentUser()
            Model.userId = Auth.auth().currentUser?.uid
        }
    }
    
    

}




