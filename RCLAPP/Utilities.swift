//
//  Utilities.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/17/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import Foundation
import UIKit

private let dateFormat = "yyyyMMddHHmmss"

func dateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter
}
