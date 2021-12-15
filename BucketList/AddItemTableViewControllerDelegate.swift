//
//  CancelButtonDelegate.swift
//  BucketList
//
//  Created by admin on 15/12/2021.
//

import Foundation
import UIKit

protocol AddItemTableViewControllerDelegate: AnyObject {
    func cancel(by controller: AddItemTableViewController)
    func addItem(by controller: AddItemTableViewController, with item: String, at indexPath: NSIndexPath?)
}
