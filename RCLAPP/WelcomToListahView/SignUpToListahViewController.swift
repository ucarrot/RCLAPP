//
//  SignUpToListahViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 09/03/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit
import KRProgressHUD

class SignUpToListahViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var signInButtonOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpButtonOutlet.layer.cornerRadius = 10
        signUpButtonOutlet.layer.borderWidth = 0.2
        signUpButtonOutlet.layer.borderColor = UIColor.brown.cgColor
    }
    
    //MARK: IBActions
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" && firstNameTextField.text != "" && lastNameTextField.text != "" {
            
            KRProgressHUD.showMessage("Signing up ...")
            //FUserOnListah
            FUser.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, completion: { (error) in
                
                if error != nil {
                
                    KRProgressHUD.showError(withMessage: "Error couldnt register")
                    return
                    
                }
                
                //go to app
                
                self.goToApp()
            })
            
        } else {
            
            KRProgressHUD.showError(withMessage: "All field are required")
        }
    }
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: GO TO APP
       
       
       func goToApp() {
           
           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome") as! UITabBarController
           
           vc.selectedIndex = 0
           
           self.present(vc, animated: true, completion: nil)
       }
    

}
