//
//  ShoppingList.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/17/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import Foundation
import Firebase

class ShoppingList {
    
    let name:String
    var totalPrice:Float
    var totalItems:Int
    var id:String
    var date:Date
    var ownerId:String
    
    init(_name:String,_totalPrice:Float=0,_id:String="") {
        
        name = _name
        totalPrice = _totalPrice
        totalItems = 0
        id = _id
        date = Date()
        ownerId = "1234"
    }
    //we recieve a dictionary from firebase (section 3 , lecture 6)
    init(dictionary:NSDictionary) {
        name = dictionary[kNAME] as! String
        totalPrice = dictionary[kTOTALPRICE] as! Float
        totalItems = dictionary[kTOTALITEMS] as! Int
        id = dictionary[kSHOPPINGLISTID] as! String
        date = dateFormatter().date(from: dictionary[kDATE] as! String)!
        ownerId = dictionary[kOWNERID] as! String
    }
    func dictionaryFromItem(item: ShoppingList) -> NSDictionary {
        
        return NSDictionary(objects: [item.name,item.totalPrice,item.totalItems,item.id,dateFormatter().string(from: item.date),item.ownerId], forKeys: [kNAME as NSCopying,kTOTALPRICE as NSCopying,kTOTALITEMS as NSCopying,kSHOPPINGLISTID as NSCopying, kDATE as NSCopying, kOWNERID as NSCopying])
    }
    //save items
    func saveItemInBackground(shoppingList: ShoppingList, completion: @escaping (_ error: Error?) -> Void) {
        
        let ref = firebase.child(kSHOPPINGLIST).child("1234").child(shoppingList.id)
        
        ref.setValue(dictionaryFromItem(item: shoppingList)) { (error, ref) -> Void in
            completion(error)
        }
    }
    //delete items
    func deleteItemInBackground(shoppingList: ShoppingList) {
        let ref = firebase.child(kSHOPPINGLIST).child("1234").child(shoppingList.id)
        ref.removeValue()
    }
    
}
