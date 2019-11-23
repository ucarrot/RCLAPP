//
//  Badges.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 21/11/2019.
//  Copyright © 2019 UCarrot Software & Design. All rights reserved.
//

import Foundation
import FirebaseFirestore

func recentBadgeCount(withBlock: @escaping(_ badgeNumber: Int) -> Void) {
    
    recentBadgeHandler = reference(.Recent).whereField(kUSERID, isEqualTo: FUser.currentId()).addSnapshotListener({ (snapshot, error) in
        
        var badge = 0
        var counter = 0
        
        guard let snapshot = snapshot else { return }
        
        if !snapshot.isEmpty {
            
            let recents = snapshot.documents
            
            for recent in recents {
                
                let currentRecent = recent.data() as NSDictionary
                
                badge += currentRecent[kCOUNTER] as! Int
                counter += 1
                
                if counter == recents.count {
                    withBlock(badge)
                }
            }
        } else {
            withBlock(badge)
        }
    })
}

func setBadges(controller: UITabBarController) {
    
    recentBadgeCount { (badge) in
        
        if badge != 0 {
            controller.tabBar.items![1].badgeValue = "\(badge)"
        } else {
            controller.tabBar.items![1].badgeValue = nil
        }
    }
}
