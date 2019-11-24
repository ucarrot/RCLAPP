//
//  FinishRegistrationViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 24/11/2019.
//  Copyright © 2019 UCarrot Software & Design. All rights reserved.
//

import UIKit

class FinishRegistrationViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var email: String!
    var password: String!
    var avatarImange: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(email, password)
    }
    

    //MARK: IBActions
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
    
    }
    
}
