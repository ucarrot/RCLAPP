//
//  Constants.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/17/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

var firebase = Database.database().reference()
let userDefaults = UserDefaults.standard

public let kSHOPPINGLISTID = "shoppingListId"
public let kSHOPPINGITEMID = "shoppingItemId"
public let kGROCERYITEMID = "groceryItemId"
public let kNAME = "name"
public let kINFO = "info"
public let kQUANTITY = "quantity"
public let kPRICE = "price"
public let kDATE = "date"
public let kTOTALPRICE = "totalPrice"
public let kOWNERID = "ownerId"
public let kSHOPPINGLIST = "ShoppingList"
public let kSHOPPINGITEM = "ShoppingItem"
public let kGROCERYITEM = "GroceryItem"
public let kISBOUGHT = "isBought"
public let kIMAGE = "image"
public let kCURRENCY = "currency"
public let kFIRSTRUN = "firstRun"
public let kOBJECTID = "objectId"
public let kCREATEDAT = "createdAt"
public let kEMAIL = "email"
public let kFIRSTNAME = "firstName"
public let kLASTNAME = "lastName"
public let kCURRENTUSER = "currentUser"
public let kUSER = "User"
public let kFULLNAME = "fullName"
public let kTOTALITEMS = "totalItems"
