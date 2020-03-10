//
//  SettingsShoppingListViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 08/03/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit

class SettingsShoppingListViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var signOutButtonOutlet: UIButton! //every button must have an action method
    
    let currencyArray = ["Dhs" , "$"]
    let currencyStringArray = ["AED, Dhs", "USD, $"]
    
    var currencyPicker: UIPickerView!
    var currencyString = ""
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        signOutButtonOutlet.layer.cornerRadius = 8
        signOutButtonOutlet.layer.borderWidth = 0.5
        signOutButtonOutlet.layer.borderColor = UIColor.gray.cgColor
        
        currencyPicker = UIPickerView()
        currencyPicker.delegate = self
        currencyTextField.inputView = currencyPicker
        
        currencyTextField.delegate = self
    }
    
//MARK: IBAction
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        FUserOnListah.logOutCurrentUser { (success) in
            
            if success! {
                
                cleanupFirebaseObservers()
                
                let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcomeToListaView")
                
                self.present(loginView, animated: true, completion: nil)
            }
        } 
        
    }
    
    //MARK: Picker View Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == currencyPicker {
            return currencyStringArray.count
        } else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == currencyPicker {
            
            return currencyStringArray[row]
        } else {
            return ""
        }
    }
    
    //MARK: Pickerview delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         
        if pickerView == currencyPicker {
            currencyTextField.text = currencyArray[row]
            
        }
        
        // save settings
        saveSettings()
        //update UI
        updateUI()
    }
    
    //MARK: SaveSettings
    
    func saveSettings() {
        
        userDefaults.set(currencyTextField.text, forKey: kCURRENCY)
        userDefaults.synchronize()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == currencyTextField {
            
            if currencyString == "" {
                
                currencyString = currencyArray[0]
            }
            currencyTextField.text = currencyString
        }
    }
    
    //MARK: UpdateUI
    
    func updateUI() {
        
        currencyTextField.text = userDefaults.object(forKey: kCURRENCY) as? String
        currencyString = currencyTextField.text!
        
    }

}
