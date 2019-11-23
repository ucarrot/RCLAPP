//
//  CollectionReference.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 21/11/2019.
//  Copyright © 2019 UCarrot Software & Design. All rights reserved.
//

import Foundation
import FirebaseFirestore


enum FCollectionReference: String {
    case User
    case Typing
    case Recent
    case Message
    case Group
    case Call
}


func reference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
