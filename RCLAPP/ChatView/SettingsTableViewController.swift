//
//  SettingsTableViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 23/01/2020.
//  Copyright © 2020 UCarrot Software & Design. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //make font big for settings tab
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    
    //MARK: IBActions
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        
        FUser.logOutCurrentUser { (success) in
            
            if success {
                //show login view
                self.showLoginView()
                
            }
            
        }
    }
    //show login view , main chat storyboard (welcome)
    func showLoginView() {
        
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome")
        
        self.present(mainView, animated: true, completion: nil)
    }
    

}
