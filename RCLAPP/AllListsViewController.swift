//
//  AllListsViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/16/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit
import KRProgressHUD

class AllListsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var allLists: [ShoppingList] = []
    var nameTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    //MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    //MARK: IBActions
    
    @IBAction func addBarItemButtonPressed(_ sender: Any) {
        //alert Controller
        let alertController = UIAlertController(title: "Create Shopping List", message: "Enter the Shopping list name", preferredStyle: .alert)
        
        alertController.addTextField{(nameTextField) in
            
            nameTextField.placeholder = "Name"
            self.nameTextField = nameTextField
        }
        //alert action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ (action) in
            
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            
            if self.nameTextField.text != ""
            {
                self.createShoppingList()
            }
            else {
                KRProgressHUD.showWarning(withMessage: "Name is Empty!")
            }
        }
        // add actions
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        //present it
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Helper functions
    
    func createShoppingList() {
        
        let shoppingList = ShoppingList(_name: nameTextField.text!)
        
        shoppingList.saveItemInBackground(shoppingList: shoppingList){(error) in
            if error != nil {
              //show error message
                KRProgressHUD.showError(withMessage: "Error creating Shopping List")
                return
            }
        }
    }
    

}
