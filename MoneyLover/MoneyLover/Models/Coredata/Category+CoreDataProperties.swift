//
//  Category+CoreDataProperties.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 11/23/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import Foundation
import CoreData

extension Category {
    
    @NSManaged var idCategory: NSNumber?
    @NSManaged var name: String?
    @NSManaged var type: NSNumber?
    @NSManaged var icon: String?
    @NSManaged var transactionWithCategory: NSSet?
    
    func getTypeInt() -> Int {
        if type == 0 {
            if name! == "Repayment" || name! == "Loan" {
                return 1
            } else {
                return 0
            }
        } else if type == 1 {
            return 1
        } else {
            return 0
        }
    }
}
