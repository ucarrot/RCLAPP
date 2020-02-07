//
//  Recent.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 25/01/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import Foundation


func startPrivateChat(user1: FUser, user2: FUser) -> String {

    let userId1 = user1.objectId
    let userId2 = user2.objectId
    
    var chatRoomId = ""
    
    let value = userId1.compare(userId2).rawValue
    
    if value < 0 {
        chatRoomId = userId1 + userId2
    } else {
        chatRoomId = userId2 + userId1
    }
    
    let members = [userId1, userId2]
    
    
    
    //create recent chats
    
    createRecent(members: members, chatRoomId: chatRoomId, withUserUserName: "", type: kPRIVATE, users: [user1, user2], avatarOfGroup: nil)
    
    return chatRoomId
}


func createRecent(members: [String], chatRoomId: String, withUserUserName: String, type: String, users: [FUser]?, avatarOfGroup: String?) {
    
    var tempMembers = members
    //database
    reference(.Recent).whereField(kCHATROOMID, isEqualTo: chatRoomId).getDocuments { (snapshot, error) in
        //check if we have snapshot in db
        guard let snapshot = snapshot else { return }
        
        //if not empty
        //this will check if members have recent chat
        if !snapshot.isEmpty {
            
            for recent in snapshot.documents {
                
                let currentRecent = recent.data() as NSDictionary
                
                if let currentUserId = currentRecent[kUSERID] {
                    
                    if tempMembers.contains(currentUserId as! String) {
                        tempMembers.remove(at: tempMembers.firstIndex(of: currentUserId as! String)!)
                    }
                }
            }
        }
        //this will create for temp members a recent chat
        for userId in tempMembers {
        //create recent items
            
            createRecentItems(userId: userId, chatRoomId: chatRoomId, members: members, withUserUserName: withUserUserName, type: type, users: users, avatarOfGroup: avatarOfGroup)
            
        }
    }

    
}

func createRecentItems(userId: String, chatRoomId: String, members: [String], withUserUserName: String, type: String, users: [FUser]?, avatarOfGroup: String?) {
    //NOTE : in database firebase it is organized like this : reference > document > NSDictionary
    let localReference = reference(.Recent).document()
    let recentId = localReference.documentID
    
    let date = dateFormatter().string(from: Date())
    
    var recent: [String : Any]!
    
    if type == kPRIVATE {
        //private
        
        var withUser: FUser?
        
        if users != nil && users!.count > 0 {
            
            if userId == FUser.currentId() {
                //for current user
                
                withUser = users!.last!
            } else {
                
                withUser = users!.first!
            }
        }
        //database dictionary
        recent = [kRECENTID: recentId, kUSERID: userId, kCHATROOMID : chatRoomId, kMEMBERS : members, kMEMBERSTOPUSH : members, kWITHUSERFULLNAME: withUser!.fullname, kWITHUSERUSERID: withUser!.objectId, kLASTMESSAGE: "", kCOUNTER: 0 , kDATE: date, kTYPE: type, kAVATAR: withUser!.avatar] as [String:Any]
        
    } else {
        
        //group
        
        if avatarOfGroup != nil {
            
            recent = [kRECENTID: recentId, kUSERID: userId, kCHATROOMID : chatRoomId, kMEMBERS : members, kMEMBERSTOPUSH : members, kWITHUSERFULLNAME: withUserUserName, kLASTMESSAGE: "", kCOUNTER: 0 , kDATE: date, kTYPE: type, kAVATAR: avatarOfGroup!] as [String:Any]
        }
        
    }
    
    //save recent chat in firebase
    localReference.setData(recent)
    
}

//restart Chat

func restartRecentChat(recent: NSDictionary) {
    
    if recent[kTYPE] as? String == kPRIVATE {
        
        createRecent(members: recent[kMEMBERSTOPUSH] as! [String],chatRoomId: recent[kCHATROOMID] as! String, withUserUserName: FUser.currentUser()!.firstname, type: kPRIVATE, users: [FUser.currentUser()!], avatarOfGroup: nil)
    }
    if recent[kTYPE] as! String == kGROUP {
        
        createRecent(members: recent[kMEMBERSTOPUSH] as! [String],chatRoomId: recent[kCHATROOMID] as! String, withUserUserName: recent[kWITHUSERUSERNAME] as! String, type: kGROUP, users: nil, avatarOfGroup: recent[kAVATAR] as? String)
    }
}

//UpdateRecents

func updateRecents(chatRoomId: String, lastMessage: String) {
    
    reference(.Recent).whereField(kCHATROOMID, isEqualTo: chatRoomId).getDocuments { (snapshot, error) in
        
        guard let snapshot = snapshot else { return }
        
        if !snapshot.isEmpty {
            
            for recent in snapshot.documents {
                
                let currentRecent = recent.data() as NSDictionary
                
                updateRecentItem(recent: currentRecent, lastMessage: lastMessage)
            }
        }
    }
}


func updateRecentItem(recent: NSDictionary, lastMessage: String) {
    
    let date = dateFormatter().string(from: Date())
    
    var counter = recent[kCOUNTER] as! Int
    
    if recent[kUSERID] as? String != FUser.currentId() {
        counter += 1
    }
    
    let values = [kLASTMESSAGE : lastMessage, kCOUNTER : counter, kDATE : date] as [String : Any]
    
    reference(.Recent).document(recent[kRECENTID] as! String).updateData(values)
}



//delete recent

func deleteRecentChat(recentChatDictionary: NSDictionary) {
    
    if let recentId = recentChatDictionary[kRECENTID] {
        
        reference(.Recent).document(recentId as! String).delete()
    }
}
