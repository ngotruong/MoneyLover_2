//
//  AddTransactionViewController.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 11/28/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let listCellViewAddTransaction = DataViewAddTransaction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        tableView?.delegate = self
        self.title = "Add Transaction"
        let buttonSave = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(saveAction))
        let buttonCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = buttonSave
        navigationItem.leftBarButtonItem = buttonCancel
        self.navigationController?.navigationBar.tintColor = UIColor.greenColor()
    }
    
    @objc private func saveAction() {
    }
    
    @objc private func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension AddTransactionViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCellViewAddTransaction.dataViewTransaction.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let viewTransaction = listCellViewAddTransaction.dataViewTransaction[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(viewTransaction.cellIdentifier, forIndexPath: indexPath)
        configCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    private func configCell(cell: UITableViewCell, forIndexPath indexPath: NSIndexPath) {
        let dataCell = listCellViewAddTransaction.dataViewTransaction[indexPath.row]
        switch cell {
        case let cell as AmountCell:
            cell.configCellWithContent(dataCell)
        case let cell as CategoryCell:
            cell.configCellWithContent(dataCell)
        case let cell as NoteCell:
            cell.configCellWithContent(dataCell)
        case let cell as DateCell:
            cell.configCellWithContent(dataCell)
        case let cell as WalletCell:
            cell.configCellWithContent(dataCell)
        case let cell as LocationCell:
            cell.configCellWithContent(dataCell)
        case let cell as PhotoCell:
            cell.configCellWithContent(dataCell)
        default:
            break
        }
    }
}

extension AddTransactionViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let dataCell = listCellViewAddTransaction.dataViewTransaction[indexPath.row]
        return dataCell.heighForCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCategoryViewController" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        }
    }
}
