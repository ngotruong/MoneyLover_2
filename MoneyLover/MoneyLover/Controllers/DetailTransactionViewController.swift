//
//  DetailTransactionViewController.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 12/7/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

protocol DeleteTransactionDelegate: class {
    func didDeleteDelete(transaction: Transaction?)
}

class DetailTransactionViewController: UITableViewController {
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var iconCategoryImageView: UIImageView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    @IBOutlet weak var amountTransactionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var transaction: Transaction?
    var transactionManager = TransactionManager()
    weak var delegate: DeleteTransactionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonEdit = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(editAction))
        navigationItem.rightBarButtonItem = buttonEdit
        if let transaction = transaction {
            iconCategoryImageView?.image = UIImage(named: (transaction.categoryWithTransaction?.icon)!)
            nameCategoryLabel?.text = (transaction.categoryWithTransaction?.name)!
            amountTransactionLabel?.text = "\(transaction.amount!)"
            dateLabel?.text = transaction.date?.getFormatDate()
            if let note = transaction.note {
                noteLabel.textColor = UIColor.lightGrayColor()
                noteLabel?.text = note
            }
        }
    }
    
    @objc private func editAction() {
        let storyBoard: UIStoryboard? = UIStoryboard(name: "AddTransaction", bundle: nil)
        if let addTransaction = storyBoard?.instantiateViewControllerWithIdentifier("AddTransactionViewController") as? AddTransactionViewController {
            addTransaction.transaction = transaction
            addTransaction.delegate = self
            let navController = UINavigationController(rootViewController: addTransaction)
            self.presentViewController(navController, animated:true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let alertController = UIAlertController(title: NSLocalizedString("DeleteTitle", comment: ""), message: NSLocalizedString("MessageDeleteTransaction", comment: ""), preferredStyle: .Alert)
                let logoutAction = UIAlertAction(title: NSLocalizedString("ButtonConfirmDelete", comment: ""), style: .Default) { (logoutaction) in
                    if let transacstionID = self.transaction?.idTransaction {
                        if self.transactionManager.deleteTransaction(transacstionID) {
                            self.delegate?.didDeleteDelete(self.transaction)
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                    }
                }
                alertController.addAction(logoutAction)
                let cancelAction = UIAlertAction(title: NSLocalizedString("ButtonTitleCancel", comment: ""), style: .Default, handler: nil)
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension DetailTransactionViewController: SaveTransactionDelegate {
    func didSaveTransaction(transactionModel: TransactionModel) {
        iconCategoryImageView?.image = UIImage(named: (transactionModel.categoryWithTransaction?.iconCategory)!)
        nameCategoryLabel?.text = (transactionModel.categoryWithTransaction?.nameCategory)!
        amountTransactionLabel?.text = "\(transactionModel.amount)"
        dateLabel?.text = transactionModel.date.getFormatDate()
        noteLabel.textColor = UIColor.lightGrayColor()
        noteLabel?.text = transactionModel.note
    }
}
