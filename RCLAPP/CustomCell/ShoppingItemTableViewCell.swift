//
//  ShoppingItemTableViewCell.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/20/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit
import SwipeCellKit

class ShoppingItemTableViewCell: SwipeTableViewCell {

    
    @IBOutlet weak var quantityBackgroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageItemView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.quantityBackgroundView.layer.cornerRadius = self.quantityBackgroundView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //shopping item class
    func bindData(item: ShoppingItem) {
        
        let currency = userDefaults.value(forKey: kCURRENCY) as! String
        
        self.nameLabel.text = item.name
        self.extraInfoLabel.text = item.info
        self.quantityLabel.text = item.quantity
        self.priceLabel.text = "\(currency) \(String(format: "%.2f", item.price))"
        
        self.priceLabel.sizeToFit()
        self.extraInfoLabel.sizeToFit()
        self.nameLabel.sizeToFit()
        
        //add image
        if item.image != "" {
            
            imageFromData(pictureData: item.image, withBlock: { (image) in
                let newImage = image!.scaleImageToSize(newSize: imageItemView.frame.size)
                self.imageItemView.image = newImage.circleMasked
            })
            
        }else {
            let newImage = UIImage(named: "ShoppingCartEmpty")!.scaleImageToSize(newSize: imageItemView.frame.size)
            self.imageItemView.image = newImage.circleMasked
        }
    }

}
