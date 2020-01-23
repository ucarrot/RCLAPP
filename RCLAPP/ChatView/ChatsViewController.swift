//
//  ChatsViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 23/01/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true


    }
    
//MARK: IBActions
    
    @IBAction func createNewChatButtonPressed(_ sender: Any) {
        
        let userVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersTableView") as! UsersTableViewController
        self.navigationController?.pushViewController(userVC, animated: true)
    }
    
}
