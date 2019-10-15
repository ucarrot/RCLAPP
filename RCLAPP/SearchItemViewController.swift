//
//  SearchItemViewController.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/29/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addButtonOutlet: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//MARK: TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    //MARK: UIActions
    
    @IBAction func addItemButtonPressed(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddItemVC") as! AddItemViewController
        vc.addingToList = true
        self.present(vc, animated: true, completion: nil)
    }
    

}
