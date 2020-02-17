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
    var test = 3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: { (user,error) in
            if error != nil {   
                let alert = UIAlertController(title: "WARNING", message: "Wrong credentials", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                    //alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated:true, completion:nil)
            } else {
                self.performSegue(withIdentifier: "fromLoginToTabBar", sender: self)
            }
        })
        
        
        /*{ (authDataResult:AuthDataResult?, error:Error?)
            if error != nil {
                let alert = UIAlertController(title: "WARNING", message: "need to fill all text boxes", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
                    //alert.dismiss(animated: true, completion: nil)
                }))
                self!.present(alert, animated:true, completion:nil)
                
            }
            else {
                
            }
        }*/
        
        
        /*Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { let alert = UIAlertController(title: "WARNING", message: "need to fill all text boxes", preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title:"CONFIRM", style:UIAlertAction.Style.default, handler: {(action) in
              //alert.dismiss(animated: true, completion: nil)
          }))
            self!.present(alert, animated:true, completion:nil)
            return
            }
          // ...
        }*/
 
    }
    
    @IBAction func toLogin(segue:UIStoryboardSegue){}
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
