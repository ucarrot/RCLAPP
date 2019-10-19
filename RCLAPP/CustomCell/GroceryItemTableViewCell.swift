//
//  GroceryItemTableViewCell.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/29/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit

class GroceryItemTableViewCell: ShoppingItemTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.quantityBackgroundView.isHidden = true
        self.quantityLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(item: GroceryItem) {
        
        self.nameLabel.text = item.name
        self.extraInfoLabel.text = item.info
        self.priceLabel.text = "AED \(String(format: "%.2f", item.price))"
        
        if item.image != "" {
            imageFromData(pictureData: item.image, withBlock: { (image) in
                self.imageItemView.image = image!.circleMasked
            })
        } else {
            let image = UIImage(named: "ShoppingCartEmpty")!.scaleImageToSize(newSize: imageItemView.frame.size)
            self.imageItemView.image = image.circleMasked
        }
    }
}
