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
//image decoded
func imageFromData(pictureData: String, withBlock: (_ image: UIImage?) -> Void) {
    
    var image: UIImage?
    let decodedData = NSData(base64Encoded: pictureData, options: NSData.Base64DecodingOptions(rawValue: 0))
    
    image = UIImage(data: decodedData! as Data)
    withBlock(image)
}

//advance coding to make image Circle / rounded
extension UIImage {
    var isPortrait: Bool {return size.height > size.width}
    var isLandscape: Bool {return size.width > size.height}
    var breadth: CGFloat {return min(size.width, size.height)}
    var breadthSize: CGSize { return CGSize(width: breadth, height: breadth)}
    var breadthRect: CGRect { return CGRect(origin: .zero, size: breadthSize)}
    var circleMasked: UIImage? { UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
            UIBezierPath(ovalIn: breadthRect).addClip()
            UIImage(cgImage: cgImage).draw(in: breadthRect)
    
        return UIGraphicsGetImageFromCurrentImageContext()
    }
// make image scaling
func scaleImageToSize(newSize: CGSize) -> UIImage {
    var scaledImageRect = CGRect.zero
    
    let aspectWidth = newSize.width/size.width
    let aspectHeight = newSize.height/size.height
    
    let aspectRatio = max(aspectWidth,aspectHeight)
    
    scaledImageRect.size.width = size.width * aspectRatio;
    scaledImageRect.size.height = size.height * aspectRatio;
    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0;
    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0;
    
    UIGraphicsBeginImageContext(newSize)
    draw(in: scaledImageRect)
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return scaledImage!
    
    }
}
