//
//  SwipeTableViewHelpers.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/22/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import Foundation
import UIKit

enum ActionDescriptor{
    case buy, returnPurchase, trash
    
    func title() -> String? {
        switch self {
        case .buy: return "Buy"
        case .returnPurchase: return "Return"
        case .trash: return "Trash"
        }
    }
    
    func image() -> UIImage? {
        
        let name : String
        
        switch self {
        case .buy: name = "BuyFilled"
        case .returnPurchase: name = "ReturnFilled"
        case .trash: name = "Trash"
        }
        
        return UIImage(named: name)
    }
    
    var color: UIColor {
        switch self {
        case .buy, .returnPurchase: return .darkGray
        case .trash: return .red
        
        }
    }
    
}
func createSelectedBackgroundView() -> UIView {
    
    let view = UIView()
    view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
    return view
}
