//
//  WelcomeViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 21/11/2019.
//  Copyright © 2019 UCarrot Software & Design. All rights reserved.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

       
    }
    @IBAction func emailTextField(_ sender: UITextField) {
    }
    
    //MARK: IBActions

    //login -------------------------------------------------
    @IBAction func loginButtonPressed(_ sender: Any) {
        dismissKeyboard()
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            loginUser()
        }
        else {
            
            ProgressHUD.showError("Email and Password is missing!")
            
        }
    }
    //register -------------------------------------------------
    @IBAction func registerButtonPressed(_ sender: Any) {
        dismissKeyboard()
        
        if emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != "" {
            //check if passwords are equal
            if passwordTextField.text == repeatPasswordTextField.text {
                registerUser()
            }else {
                ProgressHUD.showError("Passwords dont match!")
            }
            
        }
        else {
            
            ProgressHUD.showError("All fields are required!")
            
        }
        
    }
    //gesture tab -------------------------------------------------
    @IBAction func backgroundTab(_ sender: Any) {
        dismissKeyboard()
    }
    
    //MARK: HelperFunctions
    
    
    func loginUser() {
        
        ProgressHUD.show("Login..")
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) {(error) in
            
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            //present the app
            self.goToApp()
        }
    }
    //register user
    func registerUser(){
        //profile segue
        performSegue(withIdentifier: "WelcomeToFinishReg", sender: self)

        cleanTextFields()
        dismissKeyboard()
        
    }
    func dismissKeyboard(){
        self.view.endEditing(false)
        
    }
    func cleanTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
        
    }
    
    //MARK: GoToApp
    
    func goToApp() {
        
        ProgressHUD.dismiss()
        cleanTextFields()
        dismissKeyboard()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object:nil, userInfo: [kUSERID : FUser.currentId()])

        
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainChat") as! UITabBarController
        
        self.present(mainView, animated: true, completion: nil)
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check if it is the correct segue
        if segue.identifier == "WelcomeToFinishReg" {
            let vc = segue.destination as! FinishRegistrationViewController
            vc.email = emailTextField.text!
            vc.password = passwordTextField.text!
        }
    }
}
