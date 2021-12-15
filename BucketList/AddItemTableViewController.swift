//
//  ItemDetailsViewController.swift
//  BucketList
//
//  Created by admin on 15/12/2021.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    @IBOutlet weak var itemTF: UITextField!
    weak var delegate: AddItemTableViewControllerDelegate?
    var item: String?
    var indexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        itemTF.text = item
    }
    
    @IBAction func canelBtnPressed(_ sender: UIBarButtonItem) {
        print("addItemCV: cancel button pressed")
        delegate?.cancel(by: self)
    }
    
    @IBAction func doneBtnPressed(_ sender: UIBarButtonItem) {
        print("addItemCV: done button pressed")
        let text = itemTF.text!
        delegate?.addItem(by: self, with: text, at: indexPath) 
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}
