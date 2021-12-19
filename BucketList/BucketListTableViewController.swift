//
//  ViewController.swift
//  BucketList
//
//  Created by admin on 15/12/2021.
//

import UIKit
import CoreData

class BucketListTableViewController: UITableViewController {
    
    var items = [BucketListItem]()
    var newItem: String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        tableView.delegate = self //not sure if needed
        tableView.dataSource = self
        fetchAllItems()
    }
    
    func fetchAllItems(){
        do {
            items = try context.fetch(BucketListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("\(error)")
        }
    }
    
    @IBAction func addBarBtnPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "cellSegue", sender: sender)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        //cell delegate
        cell.textLabel?.text = items[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //list.remove(at: indexPath.row)
        let itemToRemove = items[indexPath.row]
        context.delete(itemToRemove)
        do {
            try context.save()
        }
        catch {}
        fetchAllItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //I know that in the tutorial, if and if-else wareused, but I don't see a need fot them here.
        let navigationC = segue.destination as! UINavigationController
        let addItemCV = navigationC.topViewController as! AddItemTableViewController
        addItemCV.delegate = self
        if sender is IndexPath {
            let indexPath  = sender as! NSIndexPath
            let item = items[indexPath.row]
            addItemCV.item = item.text
            addItemCV.indexPath = indexPath
        }
    }

}

extension BucketListTableViewController: AddItemTableViewControllerDelegate {
    
    
    func cancel(by controller: AddItemTableViewController) {
            print("BucketListVC: cancel")
            dismiss(animated: true, completion: nil)
    }
    
    func addItem(by controller: AddItemTableViewController, with item: String, at indexPath: NSIndexPath?) {
        print("BucketListVC: addItem --> \(item)")
        if let ip = indexPath { //update bucket list
            items[ip.row].text = item
        }
        else { //add new item into bucket list
            let newItem = BucketListItem(context: context)
            newItem.text = item
        }
        do {
            try self.context.save()
        }
        catch {}
        self.fetchAllItems()
        dismiss(animated: true, completion: nil)
    }
    
}

