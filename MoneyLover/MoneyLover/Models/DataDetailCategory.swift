//
//  DataDetailCategory.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/4/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class DataDetailCategory: NSObject {
    
    var cellIdentifier: String
    var heighForCell: CGFloat
    
    init(heighForCell: CGFloat, cellIdentifier: String) {
        self.heighForCell = heighForCell
        self.cellIdentifier = cellIdentifier
    }
}

class ListCellViewDetailCategory {
    
    var listCellViewDetailCategory = [DataDetailCategory]()
    
    init() {
        listCellViewDetailCategory.append(DataDetailCategory(heighForCell: 25, cellIdentifier: "empty1"))
        listCellViewDetailCategory.append(DataDetailCategory(heighForCell: 100, cellIdentifier: "empty2"))
        listCellViewDetailCategory.append(DataDetailCategory(heighForCell: 75, cellIdentifier: "nameCell"))
        listCellViewDetailCategory.append(DataDetailCategory(heighForCell: 50, cellIdentifier: "typeCell"))
        listCellViewDetailCategory.append(DataDetailCategory(heighForCell: 150, cellIdentifier: "empty3"))
        listCellViewDetailCategory.append(DataDetailCategory(heighForCell: 50, cellIdentifier: "deleteCell"))
        listCellViewDetailCategory.append(DataDetailCategory(heighForCell: 200, cellIdentifier: "empty4"))
    }
}
