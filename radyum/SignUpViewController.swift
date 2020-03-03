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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUp(_ sender: Any) {
        //make spinner
        let child = SpinnerViewController()
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        //end of makinf spinner
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
                    //end spinner
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                    //
                    self.present(alert, animated:true, completion:nil)
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    let alert = UIAlertController(title: "WARNING", message: "Account already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                        //alert.dismiss(animated: true, completion: nil)
                    }))
                    //end spinner
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                    //
                    self.present(alert, animated:true, completion:nil)
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    let alert = UIAlertController(title: "WARNING", message: "Account email already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                        //alert.dismiss(animated: true, completion: nil)
                    }))
                    //end spinner
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                    //
                    self.present(alert, animated:true, completion:nil)
                default:
                    //end spinner
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                    //
                    print("unknown error: \(err.localizedDescription)")
                }
            } else {
                //continue to app
                Model.modelFirebaseInstance.addUser(email: self.emailText.text!, name: self.userText.text!)
                //end spinner
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
                //
                self.performSegue(withIdentifier: "toLogin", sender: self)
            }
            }
        }
    }
    
    @IBAction func BackToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    
    //
    //    func isValidEmail(emailID:String)->Bool{
    //        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
    //        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    //        return emailTest.evaluate(with: emailID)
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
