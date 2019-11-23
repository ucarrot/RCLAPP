//
//  GroceryItem.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 15/10/2019.
//  Copyright © 2019 UCarrot Software & Design. All rights reserved.
//

import Foundation

class GroceryItem {
    
    var name: String
    var info: String
    var price: Float
    let ownerId: String
    var image: String
    var groceryItemId: String
    
    init(_name: String, _info: String = "", _price: Float, _image: String = "") {
        
        name = _name
        info = _info
        price = _price
        ownerId = "1234"
        image = _image
        groceryItemId = ""
    }
    
    init(dictionary:NSDictionary) {
        name = dictionary[kNAME] as! String
        info = dictionary[kINFO] as! String
        price = dictionary[kPRICE] as! Float
        image = dictionary[kIMAGE] as! String
        ownerId = dictionary[kOWNERID] as! String
        groceryItemId = dictionary[kGROCERYITEMID] as! String
    }
    //initilizer pre-defined data 
    init(shoppingItem: ShoppingItem){
        
        name = shoppingItem.name
        info = shoppingItem.info
        price = shoppingItem.price
        ownerId = "1234"
        image = shoppingItem.image
        groceryItemId = ""
    }
    
    func dictionaryFromItem(item: GroceryItem) -> NSDictionary {
        
        return NSDictionary(objects: [item.name,item.info,item.price,item.ownerId,item.image,item.groceryItemId], forKeys: [kNAME as NSCopying,kINFO as NSCopying,kPRICE as NSCopying, kOWNERID as NSCopying,kIMAGE as NSCopying, kGROCERYITEMID as NSCopying])
    }
    
    //save update and delete functions
    
    //save items
    func saveItemInBackground(groceryItem: GroceryItem, completion: @escaping (_ error: Error?) -> Void) {
        //auto id
        let ref = firebase.child(kGROCERYITEM).child("1234").childByAutoId()
        
        groceryItem.groceryItemId = ref.key!
        
        ref.setValue(dictionaryFromItem(item: groceryItem)) { (error, ref) -> Void in
            completion(error)
        }
    }
        //update items
        func updateItemInBackground(groceryItem: GroceryItem, completion: @escaping (_ error: Error?) -> Void) {
            let ref = firebase.child(kGROCERYITEM).child("1234").child(groceryItem.groceryItemId)
            ref.setValue(dictionaryFromItem(item: groceryItem)) {
                error, ref in
                
                completion(error)
            }
        }
        
        
    //delete items
    func deleteItemInBackground(groceryItem: GroceryItem) {
        let ref = firebase.child(kGROCERYITEM).child("1234").child(groceryItem.groceryItemId)
        ref.removeValue()
    }
}
