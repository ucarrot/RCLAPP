//
//  ShoppingItemViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/17/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit
import SwipeCellKit
import KRProgressHUD

class ShoppingItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate, SearchItemViewControllerDelegate {
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var itemsLeftLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var shoppingList : ShoppingList!
    
    var shoppingItems : [ShoppingItem] = []
    var boughtItems : [ShoppingItem] = []
    
    // swipe left and right
    var defaultOptions = SwipeTableOptions()
    var isSwipeRightEnabled = true
    
    var totalPrice: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadShoppingItems()
    }

    //MARK: TableView Data Source
    
        //    function 1
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
        //    function 2
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return shoppingItems.count
            
        }else {
            return boughtItems.count
        }
    }
        //    function 3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShoppingItemTableViewCell
        
        cell.delegate = self
        cell.selectedBackgroundView = createSelectedBackgroundView()
        
        var item: ShoppingItem!
        if indexPath.section == 0 {
            item = shoppingItems[indexPath.row]
            
        }else {
            item = boughtItems[indexPath.row]
        }
        cell.bindData(item: item)
        
        return cell
    }
    
    //MARK: TableViewDelegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var item: ShoppingItem!
        if indexPath.section == 0 {
            item = shoppingItems[indexPath.row]
            
        }else {
            item = boughtItems[indexPath.row]
        }
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddItemVC") as! AddItemViewController
        
        vc.shoppingList = shoppingList
        vc.shoppingItem = item
        
        self.present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var title : String!
        
        if section == 0 {
            title = "Shopping List"
        }else {
            title = "Bought List"
        }
        
        return titleViewForTable(titleText: title)
    }
    //to make empty space between two sections
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    //MARK: IBActions
    
    @IBAction func addBarButtonItemPressed(_ sender: Any) {
        
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle:.actionSheet )
        
        let newItemAction = UIAlertAction(title: "New Item", style: .default) { (action) in
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddItemVC") as! AddItemViewController
            
            vc.shoppingList = self.shoppingList
            vc.addingToList = false
            
            self.present(vc, animated: true, completion: nil)
        }
        
        let searchItemAction = UIAlertAction(title: "Search Item", style: .default) { (action) in
            //display search view
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchItemViewController
            
            vc.delegate = self
            vc.clickToEdit = false
            
            self.present(vc, animated: true, completion: nil)

            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        
        optionMenu.addAction(newItemAction)
        optionMenu.addAction(searchItemAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
       
    }
    
    //MARK: Load Shopping items
    func loadShoppingItems() {
        firebase.child(kSHOPPINGITEM).child(shoppingList.id).queryOrdered(byChild: kSHOPPINGLISTID).queryEqual(toValue: shoppingList.id).observe(.value, with: {
            
            snapshot in
            
            self.shoppingItems.removeAll()
            self.boughtItems.removeAll()
            
            if snapshot.exists() {
                let allItems = (snapshot.value as! NSDictionary).allValues as Array
                for item in allItems {
                    let currentItem = ShoppingItem.init(dictionary: item as! NSDictionary)
                    
                    if currentItem.isBought {
                        self.boughtItems.append(currentItem)
                    } else {
                        self.shoppingItems.append(currentItem)
                    }
                }
            } else {
                print("no snapshots")
            }
            
            self.calculateTotal()
            self.updateUI()
        
        })
    }
    
    func updateUI() {
        self.itemsLeftLabel.text = "Items Left: \(self.shoppingItems.count)"
        self.totalPriceLabel.text = "Total Price: AED\(String (format: "%0.2f", self.totalPrice!))"
        
        self.tableView.reloadData()
    }
    //MARK: SwipeTableViewCell delegate functions
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        var item : ShoppingItem!
        
        if indexPath.section == 0 {
            item = shoppingItems[indexPath.row]
        }else {
            item = boughtItems[indexPath.row]
        }
        if orientation == .left {
            guard isSwipeRightEnabled else {return nil}
            
            let buyItem = SwipeAction(style: .default, title: nil, handler: { action, indexPath in
                
                item.isBought = !item.isBought
                item.updateItemInBackground(shoppingItem: item, completion: { (error) in
                    if error != nil {
                        KRProgressHUD.showError(withMessage: "Error couldnt update item")
                        return
                    }
                    })
                
                if indexPath.section == 0 {
                        self.shoppingItems.remove(at: indexPath.row)
                        self.boughtItems.append(item)
                    }else {
                        self.shoppingItems.append(item)
                        self.boughtItems.remove(at: indexPath.row)
                    }
                    tableView.reloadData()
            })
            buyItem.accessibilityLabel = item.isBought ? "Buy" : "Return"
            let descriptor: ActionDescriptor = item.isBought ? .returnPurchase : .buy
            
            configure(action: buyItem, with: descriptor)
            
            return [buyItem]
        } else {
            let delete = SwipeAction(style: .destructive, title: nil, handler: { (action, indexPath) in
                if indexPath.section == 0 {
                    self.shoppingItems.remove(at: indexPath.row)
                } else {
                    self.boughtItems.remove(at: indexPath.row)
                }
                item.deleteItemInBackground(shoppingItem: item)
                
                self.tableView.beginUpdates()
                action.fulfill(with: .delete)
                self.tableView.endUpdates()
            })
            configure(action: delete, with: .trash)
            return [delete]
        }
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
    
    //MARK : Helper functions
    func calculateTotal() {
        self.totalPrice = 0
        
        for item in boughtItems {
            self.totalPrice = self.totalPrice + item.price
        }
        for item in shoppingItems {
            totalPrice = totalPrice + item.price
        }
        self.totalPriceLabel.text = "Total Price: \(String(format:"%0.2f",self.totalPrice!))"
        shoppingList.totalPrice = self.totalPrice
        shoppingList.totalItems = self.boughtItems.count + self.shoppingItems.count
        
        shoppingList.updateItemInBackground(shoppingList: shoppingList) { (error) in
            if error != nil {
                KRProgressHUD.showError(withMessage: "Error updating shopping list")
                return
            }
        }
    }
    func titleViewForTable(titleText: String) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .darkGray
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 200, height: 20))
        titleLabel.text = titleText
        titleLabel.textColor = .white
        
        view.addSubview(titleLabel)
        
        return view
    }
    
    //MARK: SearchItemViewControllerDelegate
    
    func didChooseItem(groceryItem: GroceryItem) {
        //print("did choose item \(groceryItem.name)")
        
        let shoppingItem = ShoppingItem(groceryItem: groceryItem)
        shoppingItem.shoppingListId = shoppingList.id
        
        shoppingItem.saveItemInBackground(shoppingItem: shoppingItem) { (error) in
            
            if error != nil {
                
                KRProgressHUD.showError(withMessage: "Error choosing item")
                return
            }
        }
    }

}
