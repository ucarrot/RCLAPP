//
//  ListTableViewCell.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/18/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func binData(item: ShoppingList) {
        
        let currency = "Dhs"//userDefaults.value(forKey: kCURRENCY) as! String
        
        let currentDateFormatter = dateFormatter()
        currentDateFormatter.dateFormat = "dd/MM/YYYY"
        
        let date = currentDateFormatter.string(from: item.date)
        
        self.nameLabel.text = item.name
        self.totalItemsLabel.text = "\(item.totalItems) Items"
        self.totalPriceLabel.text = "Total \(currency) \(String(format:"%0.2f", item.totalPrice))"
        self.dateLabel.text = date
        
        self.totalPriceLabel.sizeToFit()
        self.nameLabel.sizeToFit()
    }

}
