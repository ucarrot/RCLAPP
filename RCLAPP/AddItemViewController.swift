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
    var shoppingItem : ShoppingItem?
    
    var addingToList: Bool?
    
    var itemImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "ShoppingCartEmpty")!.scaleImageToSize(newSize: itemImageView.frame.size)
        itemImageView.image = image.circleMasked
        
        if shoppingItem != nil {
            updateUI()
        }
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
            if shoppingItem != nil {
                self.updateItem()
            }else {
                saveItem()
            }
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
    func updateItem(){
        var imageData: String!
        
        if itemImage != nil {
            let image = itemImage!.jpegData(compressionQuality: 0.5)
            imageData = image?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        }else {
            imageData = ""
        }
        
        if shoppingItem != nil {
            shoppingItem!.name = nameTextField.text!
            shoppingItem!.info = extraInfoTextField.text!
            shoppingItem!.quantity = quantityTextField.text!
            shoppingItem!.price = Float(priceTextField.text!)!
            
            shoppingItem!.image = imageData
            
            shoppingItem?.updateItemInBackground(shoppingItem: shoppingItem!, completion: {
                (error) in
                
                if error != nil {
                    KRProgressHUD.showError(withMessage: "Error updating item")
                    return
                }
            })
            
        }else {
            //update grocery item
        }
    }
    func saveItem() {
        
        var shoppingItem: ShoppingItem
        
        var imageData: String!
        
        if itemImage != nil {
            let image = itemImage!.jpegData(compressionQuality: 0.5)
            imageData = image?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        } else {
            imageData = ""
        }
        
        if addingToList! {
            //add to groceryList only
            shoppingItem = ShoppingItem(_name: nameTextField.text!, _info: extraInfoTextField.text!, _price: Float(priceTextField.text!)!, _shoppingListId: "")
            
            let groceryItem = GroceryItem(shoppingItem: shoppingItem)
            groceryItem.image = imageData
            
            groceryItem.saveItemInBackground(groceryItem: groceryItem, completion:{ (error) in
            
                if error != nil {
                
                    KRProgressHUD.showError(withMessage: "Error saving grocery item")
                return
                }
            })
            self.dismiss(animated: true, completion: nil)
            
        }else {
            // add to current shopping list
            let shoppingItem = ShoppingItem(_name: nameTextField.text!, _info: extraInfoTextField.text!, _quantity: quantityTextField.text!, _price: Float(priceTextField.text!)!, _shoppingListId: shoppingList.id)
            shoppingItem.image = imageData
            shoppingItem.saveItemInBackground(shoppingItem: shoppingItem) { (error) in
            if error != nil {
                
                    KRProgressHUD.showError(withMessage: "Error saving shopping item ")
                    return
                }
                
            }
        }
  
    }
    //MARK: UIImagePikerController delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        self.itemImage = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as! UIImage)
        
        let newImage = itemImage!.scaleImageToSize(newSize: itemImageView.frame.size)
        self.itemImageView.image = newImage.circleMasked
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UpdateUI
    
    func updateUI() {
        if shoppingItem != nil {
            self.nameTextField.text = self.shoppingItem!.name
            self.extraInfoTextField.text = self.shoppingItem!.info
            self.quantityTextField.text = self.shoppingItem!.quantity
            self.priceTextField.text = "\(self.shoppingItem!.price)"
            
            if shoppingItem!.image != "" {
                imageFromData(pictureData: shoppingItem!.image, withBlock: {(image) in
                    
                    self.itemImage = image!
                    let newImage = image!.scaleImageToSize(newSize: itemImageView.frame.size)
                    self.itemImageView.image = newImage.circleMasked
                    
                })
            }
        }
    }
   
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
