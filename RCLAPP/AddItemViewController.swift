//
//  AddItemViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/19/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit
import KRProgressHUD

class AddItemViewController: UIViewController {

    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var extraInfoTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    var shoppingList : ShoppingList!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: IBAction
    
    @IBAction func saveButtonPressed(_ sender: Any) {
            //check if the item details is empty
        if nameTextField.text != "" && priceTextField.text != "" {
            saveItem()
        }
           
        else {
            KRProgressHUD.showWarning(withMessage: "Empty Fields!")
        }
    }
     //dismiss if cancel
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Save item
    func saveItem() {
        let shoppingItem = ShoppingItem(_name: nameTextField.text!, _info: extraInfoTextField.text!, _quantity: quantityTextField.text!, _price: Float(priceTextField.text!)!, _shoppingListId: shoppingList.id)
        
        shoppingItem.saveItemInBackground(shoppingItem: shoppingItem) { (error) in
        if error != nil
            {
                KRProgressHUD.showError(withMessage: "Error saving shopping item ")
                return
            }
        }

    }
   
}
