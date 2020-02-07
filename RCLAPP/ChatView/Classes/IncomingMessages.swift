//
//  IncomingMessages.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 01/02/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class IncomingMessage {
    
    var collectionView: JSQMessagesCollectionView
    
    init(collectionView_: JSQMessagesCollectionView) {
        
        collectionView = collectionView_
        
    }
    
    //MARK: CreateMessage
    
    func createMessage(messageDictionary: NSDictionary, chatRoomId: String) -> JSQMessage? {
        var message: JSQMessage?
        
        let type = messageDictionary[kTYPE] as! String
        
        switch type {
        case kTEXT:
            //create text message
            message = createTextMessage(messageDictionary: messageDictionary, chatRoomId: chatRoomId)
        case kPICTURE:
            //create Picture message
            print("create picture message")
        case kVIDEO:
            //create Video message
            print("create video message")
        case kAUDIO:
            //create Audio message
            print("create audio message")
        case kLOCATION:
            //create location message
            print("create location message")
        default:
            print("Unknow message type")
        }
        
        if message != nil {
            return message
        }
        
        return nil
    }
    
    //MARK: Create Message types
    
    func createTextMessage(messageDictionary: NSDictionary, chatRoomId: String) -> JSQMessage {
        
        let name = messageDictionary[kSENDERNAME] as? String
        let userId = messageDictionary[kSENDERID] as? String
        
        var date: Date!
        
        if let created = messageDictionary[kDATE] {
            
            if (created as! String).count != 14 {
                date = Date()
            } else {
                date = dateFormatter().date(from: created as! String)
            }
        }else {
            date = Date()
        }
        
        let text = messageDictionary[kMESSAGE] as! String
        
        return JSQMessage(senderId: userId, senderDisplayName: name, date: date, text: text)
        
    }
}
