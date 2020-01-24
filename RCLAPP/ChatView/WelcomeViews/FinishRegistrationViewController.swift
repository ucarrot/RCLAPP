//
//  FinishRegistrationViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 24/11/2019.
//  Copyright © 2019 UCarrot Software & Design. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var email: String!
    var password: String!
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(email, password)
    }
    

    //MARK: IBActions
    //cancel button
    @IBAction func cancelButtonPressed(_ sender: Any) {
        cleanTextFields()
        dismissKeyboard()
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    //done button
    @IBAction func doneButtonPressed(_ sender: Any) {
       
        dismissKeyboard()
        ProgressHUD.show("Registering...")
        
        if nameTextField.text != "" && surnameTextField.text != "" && countryTextField.text != "" && cityTextField.text != "" && phoneTextField.text != "" {
            //firebase authentication
            FUser.registerUserWith(email: email!, password: password!, firstName: nameTextField.text! , lastName: surnameTextField.text!) { (error) in
                
                if error != nil {
                    ProgressHUD.dismiss()
                    ProgressHUD.showError(error!.localizedDescription) //human readable error
                    return
                }
                
            }
            self.registerUser()
        }
        else {
            
        }
    
    }
    //MARK: Helpers
    
    func registerUser() {
         
        let fullName = nameTextField.text! + " " + surnameTextField.text!
        
        //dictionary
       var tempDictionary : Dictionary = [kFIRSTNAME : nameTextField.text!, kLASTNAME : surnameTextField.text!, kFULLNAME : fullName, kCOUNTRY: countryTextField.text!
        , kCITY : cityTextField.text!, kPHONE : phoneTextField.text!] as [String: Any]
        
        if avatarImage == nil {
            
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (avatarInitials) in
                
                let avatarIMG = avatarInitials.pngData() //NOTE: i have replaced jpegData with pngData
                let avatar = avatarIMG!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                               
                tempDictionary[kAVATAR] = avatar
                               
                self.finishRegistration(withValues: tempDictionary)
            }
            
        } else {
            
            let avatarData = avatarImage?.pngData() //NOTE: i have replaced jpegData with pngData
            let avatar = avatarData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                       
             tempDictionary[kAVATAR] = avatar
            
            //finish registration
            self.finishRegistration(withValues: tempDictionary)
        }
        
    }
    //finish registration
    func finishRegistration(withValues: [String : Any]) {
        
        updateCurrentUserInFirestore(withValues: withValues) { (error) in
            
            if error != nil {
                
                DispatchQueue.main.async {
                    ProgressHUD.showError(error!.localizedDescription)
                    print(error!.localizedDescription)
                }
                
                return //if we have an error
            }
            
            ProgressHUD.dismiss()
            self.goToApp()
        }
    }
    
    func goToApp() {
        cleanTextFields()
        dismissKeyboard()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object:nil, userInfo: [kUSERID : FUser.currentId()])
        
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainChat") as! UITabBarController
        
        self.present(mainView, animated: true, completion: nil)
        
    }
    
    func dismissKeyboard(){
         self.view.endEditing(false)
         
     }
     func cleanTextFields() {
         nameTextField.text = ""
         surnameTextField.text = ""
         countryTextField.text = ""
         cityTextField.text = ""
         phoneTextField.text = ""
         
     }
    
}
