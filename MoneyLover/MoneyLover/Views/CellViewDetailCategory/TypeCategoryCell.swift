//
//  TypeCategoryCell.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/4/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class TypeCategoryCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellWithContent(category: Category) {
        if category.type == 0 {
            if category.name == "Repayment" || category.name == "Loan" {
                self.textLabel?.text = "Expense"
            } else {
                self.textLabel?.text = "Income"
            }
        } else if category.type == 1 {
            self.textLabel?.text = "Expense"
        } else {
            self.textLabel?.text = "Income"
        }
        self.imageView?.image = UIImage(named: "ic_income_expense")
    }
}
