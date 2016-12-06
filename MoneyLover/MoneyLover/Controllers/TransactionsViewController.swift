//
//  TransactionsViewController.swift
//  MoneyLover
//
//  Created by Phung Tung on 11/24/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var transactionManager = TransactionManager()
    var listTranasction = [Transaction]()
    var openBalance = 0.0
    var endingBalance = 0.0
    var result = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationbarAndTabbarStyle()
        self.tabBarController?.delegate = self
        tableView?.registerNib(UINib(nibName: "OverViewTableViewCell", bundle: nil), forCellReuseIdentifier: "OverViewCell2")
        tableView?.registerNib(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionCell2")
        tableView?.registerNib(UINib(nibName: "HeaderTransactionSection", bundle: nil), forHeaderFooterViewReuseIdentifier: "TransactionHeader2")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var typeCategories = 0
        openBalance = 0.0
        endingBalance = 0.0
        result = 0.0
        listTranasction.removeAll()
        listTranasction.appendContentsOf(transactionManager.showTransaction())
        for transaction in listTranasction {
            typeCategories = (transaction.categoryWithTransaction?.getTypeInt())!
            if typeCategories == 1 {
                if let amount = transaction.amount {
                    endingBalance = endingBalance - amount.doubleValue
                }
            } else {
                if let amount = transaction.amount {
                    openBalance = openBalance + amount.doubleValue
                }
            }
        }
        result = openBalance + endingBalance
        tableView?.reloadData()
    }
    
    private func navigationbarAndTabbarStyle() {
        self.tabBarController?.tabBar.tintColor = UIColor(red: 30.0 / 255, green: 188.0 / 255, blue: 94.0 / 255, alpha: 1)
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0 / 255, green: 188.0 / 255, blue: 94.0 / 255, alpha: 1)
        self.navigationController?.navigationBar.barStyle = .BlackTranslucent
    }
}

extension TransactionsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return listTranasction.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCellWithIdentifier("OverViewCell2", forIndexPath: indexPath) as? OverViewTableViewCell {
                cell.openBalanceLabel?.text = "\(openBalance)"
                cell.endingBalanceLabel?.text = "\(endingBalance)"
                cell.overViewLabel?.text = "\(result)"
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCellWithIdentifier("TransactionCell2", forIndexPath: indexPath) as? TransactionTableViewCell {
                let transaction = listTranasction[indexPath.row]
                transaction.categoryWithTransaction?.type = transaction.categoryWithTransaction?.getTypeInt()
                if transaction.categoryWithTransaction?.type == 1 {
                    cell.moneyLabel?.text = "-\(transaction.amount!)"
                } else {
                    cell.moneyLabel?.text = "\(transaction.amount!)"
                }
                cell.moneyLabel?.textColor = UIColor.redColor()
                cell.iconCategoryImageView?.image = UIImage(named: (transaction.categoryWithTransaction?.icon)!)
                cell.nameCategoryLabel?.text = transaction.categoryWithTransaction?.name
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110
        }
        return 50
    }
}

extension TransactionsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if let detailTransaction = self.storyboard?.instantiateViewControllerWithIdentifier("DetailTransactionViewController") as? DetailTransactionViewController {
                let transaction = listTranasction[indexPath.row]
                detailTransaction.transaction = transaction
                //                detailTransaction.delegate = self
                self.navigationController?.pushViewController(detailTransaction, animated: true)
            }
        }
    }
}

extension TransactionsViewController: UITabBarControllerDelegate {
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if tabBarController.selectedIndex == 2 {
            let storyBoard: UIStoryboard? = UIStoryboard(name: "AddTransaction", bundle: nil)
            if let addTransaction = storyBoard?.instantiateViewControllerWithIdentifier("AddTransactionViewController") as? AddTransactionViewController {
                let navController = UINavigationController(rootViewController: addTransaction)
                self.presentViewController(navController, animated:true, completion: nil)
            }
        }
    }
}

extension TransactionsViewController: DeleteTransactionDelegate {
    
    func didDeleteDelete(transaction: Transaction?) {
        var typeCategories = 0
        if let transaction = transaction {
            typeCategories = (transaction.categoryWithTransaction?.getTypeInt())!
            if typeCategories == 1 {
                if let amount = transaction.amount {
                    endingBalance = endingBalance + amount.doubleValue
                }
            } else {
                if let amount = transaction.amount {
                    openBalance = openBalance - amount.doubleValue
                }
            }
            result = openBalance + endingBalance
            self.tableView?.reloadData()
        }
    }
}
