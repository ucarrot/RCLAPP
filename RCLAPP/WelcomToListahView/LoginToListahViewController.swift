//
//  LoginToListahViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 09/03/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit
import KRProgressHUD

class LoginToListahViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var LogoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //LogoImageView.layer.cornerRadius = 8
        signInButtonOutlet.layer.cornerRadius = 10
        signInButtonOutlet.layer.borderWidth = 0.2
        signInButtonOutlet.layer.borderColor = UIColor.brown.cgColor
        signUpButtonOutlet.layer.cornerRadius = 10
        signUpButtonOutlet.layer.borderWidth = 0.2
        signUpButtonOutlet.layer.borderColor = UIColor.brown.cgColor
      
        KRProgressHUD.dismiss()
        
        
    }
    

    //MARK: IBActions
    
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            KRProgressHUD.showMessage("Signing in...")
            //FUserOnListah
            FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
                
                if error != nil {
                    
                    KRProgressHUD.showError(withMessage: "Error login !")
                }
                
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
                self.view.endEditing(true)
                
                //go to app
                self.goToApp()
            }
        }
    }
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        
        if emailTextField.text != "" {
            
            resetUserPassword(email: emailTextField.text!)
            
        } else {
            
            KRProgressHUD.showError(withMessage: "Email is empty!")
        }
    }
    
    //MARK: GO TO APP
    
    
    func goToApp() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome") as! UITabBarController
        
        vc.selectedIndex = 0
        
        self.present(vc, animated: true, completion: nil)
    }
}
