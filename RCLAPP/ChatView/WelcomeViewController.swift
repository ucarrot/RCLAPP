//
//  WelcomeViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 21/11/2019.
//  Copyright © 2019 UCarrot Software & Design. All rights reserved.
//

import UIKit

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

    //login
    @IBAction func loginButtonPressed(_ sender: Any) {
        dismissKeyboard()
    }
    //register
    @IBAction func registerButtonPressed(_ sender: Any) {
        dismissKeyboard()
    }
    //gesture tab
    @IBAction func backgroundTab(_ sender: Any) {
        dismissKeyboard()
    }
    
    //MARK: HelperFunctions
    
    func dismissKeyboard(){
        self.view.endEditing(false)
        
    }
    func cleanTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
        
    }
}
