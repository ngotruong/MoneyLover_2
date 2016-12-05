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
    
    func configCellWithContent(category: CategoryModel) {
        if category.typeCategory == 0 {
            if category.nameCategory == "Repayment" || category.nameCategory == "Loan" {
                self.textLabel?.text = "Expense"
            } else {
                self.textLabel?.text = "Income"
            }
        } else if category.typeCategory == 1 {
            self.textLabel?.text = "Expense"
        } else {
            self.textLabel?.text = "Income"
        }
        self.imageView?.image = UIImage(named: "ic_income_expense")
    }
}
