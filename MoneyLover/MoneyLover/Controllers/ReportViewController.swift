//
//  ReportViewController.swift
//  MoneyLover
//
//  Created by Phung Tung on 11/24/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    
    @IBOutlet weak var endBalanceLabel: UILabel!
    @IBOutlet weak var openBalanceLabel: UILabel!
    var transactionManager = TransactionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var typeCategories = 0
        var openBalance = 0.0
        var endingBalance = 0.0
        for transaction in transactionManager.showTransaction() {
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
        endBalanceLabel?.text = "\(endingBalance)"
        openBalanceLabel?.text = "\(openBalance)"
    }
}
