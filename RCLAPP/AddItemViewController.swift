//
//  AddItemViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/19/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit
import KRProgressHUD

class AddItemViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var extraInfoTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    var shoppingList : ShoppingList!
    
    var itemImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: IBAction
    
    @IBAction func addImageButtonPressed(_ sender: Any) {
        
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet )
        let camera = Camera(delegate_: self)
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            
            camera.PresentPhotoCamera(target: self, canEdit: true)
            
            }
        
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            
            camera.PresentPhotoLibrary(target: self, canEdit: true)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
            //check if the item details is empty
        if nameTextField.text != "" && priceTextField.text != "" {
            saveItem()
        }
           
        else {
            KRProgressHUD.showWarning(withMessage: "Empty Fields!")
        }
        self.dismiss(animated: true, completion: nil)
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
    //MARK: UIImagePikerController delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.itemImage = (info[UIImagePickerControllerEditedImage] as! UIImage)
        
        let newImage = itemImage!.scaleImageToSize(newSize: itemImageView.frame.size)
        self.itemImageView.image = newImage.circleMasked
        
        picker.dismiss(animated: true, completion: nil)
    }
   
}
