//
//  AddTransactionViewController.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 11/28/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

protocol SaveTransactionDelegate: class {
    func didSaveTransaction(transactionModel: TransactionModel)
}

class AddTransactionViewController: UITableViewController {
    
    @IBOutlet weak var inputAmountTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var iconCategoryImageView: UIImageView!
    @IBOutlet weak var nameCategoryLabel: UILabel!
    var transaction: Transaction?
    var category: CategoryModel?
    var dateCurrent = NSDate()
    var noteCurrent: String?
    var wallet: Wallet?
    var transactionManager = TransactionManager()
    weak var delegate: SaveTransactionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let transaction = transaction {
            self.title = "Edit Transaction"
            self.inputAmountTextField?.text = "\(transaction.amount!)"
            self.dateLabel?.text = transaction.date?.getFormatDate()
            self.noteLabel?.text = transaction.note!
            self.iconCategoryImageView?.image = UIImage(named: (transaction.categoryWithTransaction?.icon)!)
            self.nameCategoryLabel?.text = transaction.categoryWithTransaction?.name
        } else {
            self.title = "Add Transaction"
        }
        let buttonSave = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(saveAction))
        let buttonCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = buttonSave
        navigationItem.leftBarButtonItem = buttonCancel
        self.navigationController?.navigationBar.tintColor = UIColor.greenColor()
        self.dateLabel?.text = getDateCurrent()
        inputAmountTextField?.keyboardType = .NumberPad
    }
    
    @objc private func saveAction() {
        if let transaction = transaction {
            if let amount = inputAmountTextField?.text {
                let transactionModel = TransactionModel()
                transactionModel.date = dateCurrent
                if let noteCurrent = noteCurrent {
                    transactionModel.note = noteCurrent
                }
                if let amount = Double(amount), let category = category {
                    transactionModel.amount = amount
                    transactionModel.categoryWithTransaction = category
                    transactionModel.idTransaction = (transaction.idTransaction?.integerValue)!
                    if transactionManager.editTransaction(transactionModel) {
                        self.delegate?.didSaveTransaction(transactionModel)
                        showMainStoryboard()
                    }
                }
            } else {
                showMainStoryboard()
            }
        } else {
            if let category = category, let amount = inputAmountTextField?.text {
                let transactionModel = TransactionModel()
                transactionModel.categoryWithTransaction = category
                transactionModel.date = dateCurrent
                if let noteCurrent = noteCurrent {
                    transactionModel.note = noteCurrent
                }
                if let amount = Double(amount) {
                    transactionModel.amount = amount
                    if transactionManager.addTransaction(transactionModel) {
                        showMainStoryboard()
                    }
                } else {
                    self.presentAlertWithTitle("Error", message: "ReEnter Amount")
                }
            }
        }
    }
    
    @objc private func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func showMainStoryboard() {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let home = mainStoryboard.instantiateViewControllerWithIdentifier("TabbarController") as? UITabBarController {
                appDelegate.window?.rootViewController = home
                appDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCategoryViewController" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
            if let showCategories = segue.destinationViewController as? ShowCategoryViewController {
                showCategories.delegate = self
            }
        } else if segue.identifier == "NoteViewController" {
            if let noteViewController = segue.destinationViewController as? NoteViewController {
                noteViewController.delegate = self
                noteViewController.noteCurrent = noteCurrent
            }
        } else if segue.identifier == "DateViewController" {
            if let dateViewController = segue.destinationViewController as? DateViewController {
                dateViewController.delegate = self
                dateViewController.dateDidChoose = dateCurrent
            }
        }
    }
    
    private func getDateCurrent() -> String {
        let date = NSDate()
        return "\(date.weekDay), \(date.day) \(date.month) \(date.year)"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 6 {
            //            let storyBoard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
            //            if let addWalletViewController = storyBoard?.instantiateViewControllerWithIdentifier("ChooseWalletTableViewController") as? ChooseWalletTableViewController {
            //                let navController = UINavigationController(rootViewController: addWalletViewController)
            //                self.presentViewController(navController, animated:true, completion: nil)
            //            }
        }
    }
}

extension AddTransactionViewController: DataNote {
    func didInputNote(string: String) {
        if string == "" {
            self.noteLabel?.textColor = UIColor.lightGrayColor()
            self.noteLabel?.text = "Note"
            self.noteCurrent = nil
        } else {
            self.noteCurrent = string
            self.noteLabel?.textColor = UIColor.blackColor()
            self.noteLabel?.text = string
        }
    }
}

extension AddTransactionViewController: ChooseCategoryDelegate {
    func didChooseCategory(categoryModel: CategoryModel?) {
        if let categoryModel = categoryModel {
            category = categoryModel
            nameCategoryLabel?.textColor = UIColor.blackColor()
            iconCategoryImageView?.image = UIImage(named: categoryModel.iconCategory)
            nameCategoryLabel?.text = categoryModel.nameCategory
        }
    }
}

extension AddTransactionViewController: ChooseDateDelegate {
    func didChooseDate(date: NSDate?) {
        if let date = date {
            self.dateCurrent = date
            self.dateLabel?.text = date.getFormatDate()
        }
    }
}
