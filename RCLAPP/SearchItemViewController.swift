//
//  SearchItemViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/29/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit
import SwipeCellKit

class SearchItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  SwipeTableViewCellDelegate{

    @IBOutlet weak var addButtonOutlet: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    //array
    var groceryItems:  [GroceryItem] = []
    
    var defaultOptions = SwipeTableOptions()
    var isSwipeRightEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGroceryItems()
    }
//MARK: TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groceryItems.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroceryItemTableViewCell
        
        cell.delegate = self
        cell.selectedBackgroundView = createSelectedBackgroundView()
        
        let groceryItem = groceryItems[indexPath.row]
        
        cell.bindData(item: groceryItem)
        
        return cell
    }
    //MARK: UIActions
    
    @IBAction func addItemButtonPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddItemVC") as! AddItemViewController
        vc.addingToList = true
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: Load grocery Itemes
    
    func loadGroceryItems() {
        
        firebase.child(kGROCERYITEM).child("1234").observe(.value, with: {
            snapshot in
            
            self.groceryItems.removeAll()
            
            if snapshot.exists() {
                let allItems = (snapshot.value as! NSDictionary).allValues as Array
                
                for item in allItems {
                    let currentItem = GroceryItem(dictionary: item as! NSDictionary)
                    
                    self.groceryItems.append(currentItem)
                }
            } else {
                
                print("no snapshot")
            }
            
            self.tableView.reloadData()
        })
    }

    
    //MARK: SwipeTableViewCell delegate functions
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
       
        if orientation == .left {
            guard isSwipeRightEnabled else {return nil}
        }
          
        let delete = SwipeAction(style: .destructive, title: nil, handler: { (action, indexPath) in
            
            var item: GroceryItem
            
            item = self.groceryItems[indexPath.row]
            
            self.groceryItems.remove(at: indexPath.row)
            
            item.deleteItemInBackground(groceryItem: item)
            
            self.tableView.beginUpdates()
            action.fulfill(with: .delete)
            self.tableView.endUpdates()
        })
        configure(action: delete, with: .trash)
        return [delete]
    }
    
    
    func configure(action: SwipeAction, with descriptor: ActionDescriptor) {
        
        action.title =  descriptor.title()
        action.image = descriptor.image()
        action.backgroundColor = descriptor.color
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeTableOptions()
        options.expansionStyle = orientation == .left ? .selection : .destructive
        options.transitionStyle = defaultOptions.transitionStyle
        options.buttonSpacing = 11
        
        return options
    }
}
