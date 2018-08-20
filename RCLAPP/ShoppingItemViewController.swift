//
//  ShoppingItemViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/17/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit

class ShoppingItemViewController: UIViewController {

    
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var itemsLeftLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var shoppingList : ShoppingList!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: IBActions
    
    @IBAction func addBarButtonItemPressed(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddItemVC") as! AddItemViewController
        
        vc.shoppingList = self.shoppingList
        self.present(vc, animated: true, completion: nil)
    }
    

}
