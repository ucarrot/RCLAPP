//
//  AllListsViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/16/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit

class AllListsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var allLists: [ShoppingList] = []
    
    
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
        
        
    }
    

}
