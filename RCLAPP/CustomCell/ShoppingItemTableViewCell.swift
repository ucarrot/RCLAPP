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

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageItemView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //shopping item class
    func bindData(item: ShoppingItem) {
        
        self.nameLabel.text = item.name
        self.extraInfoLabel.text = item.info
        self.quantityLabel.text = item.quantity
        self.priceLabel.text = "AED \(item.price)"
        
        self.priceLabel.sizeToFit()
        self.extraInfoLabel.sizeToFit()
        self.nameLabel.sizeToFit()
        
        //add image
    }

}
