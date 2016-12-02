//
//  CategoryModel.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 12/2/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {

    var nameCategory = ""
    var typeCategory = 0
    var iconCategory = ""
    var idCategory = 0
    
    
    init(nameCategory: String, typeCategory: Int, iconCategory: String, idCategory: Int) {
        self.nameCategory = nameCategory
        self.typeCategory = typeCategory
        self.iconCategory = iconCategory
        self.idCategory = idCategory
    }
}

class ListCategoryAvailable {
    
    var listCategory = [CategoryModel]()
    
    init() {
        listCategory.append(CategoryModel(nameCategory: "Bill & Utilities", typeCategory: 1, iconCategory: "icon_4", idCategory: 1))
        listCategory.append(CategoryModel(nameCategory: "Phone ", typeCategory: 1, iconCategory: "icon_9", idCategory: 2))
        listCategory.append(CategoryModel(nameCategory: "Water", typeCategory: 1, iconCategory: "icon_12", idCategory: 3))
        listCategory.append(CategoryModel(nameCategory: "Electricity", typeCategory: 1, iconCategory: "icon_26", idCategory: 4))
        listCategory.append(CategoryModel(nameCategory: "Gas", typeCategory: 1, iconCategory: "icon_19", idCategory: 5))
        listCategory.append(CategoryModel(nameCategory: "Television", typeCategory: 1, iconCategory: "icon_20", idCategory: 6))
        listCategory.append(CategoryModel(nameCategory: "Internet", typeCategory: 1, iconCategory: "icon_21", idCategory: 7))
        listCategory.append(CategoryModel(nameCategory: "Cafe", typeCategory: 1, iconCategory: "icon_15", idCategory: 8))
        listCategory.append(CategoryModel(nameCategory: "Shopping", typeCategory: 1, iconCategory: "icon_30", idCategory: 9))
        listCategory.append(CategoryModel(nameCategory: "Friends & Lover", typeCategory: 1, iconCategory: "ic_category_friendnlover", idCategory: 10))
        listCategory.append(CategoryModel(nameCategory: "Loan", typeCategory: 0, iconCategory: "ic_category_loan", idCategory: 11))
        listCategory.append(CategoryModel(nameCategory: "Repayment", typeCategory: 0, iconCategory: "icon_31", idCategory: 12))
        listCategory.append(CategoryModel(nameCategory: "Debt", typeCategory: 0, iconCategory: "ic_category_debt", idCategory: 13))
        listCategory.append(CategoryModel(nameCategory: "Debt Colection", typeCategory: 0, iconCategory: "icon_33", idCategory: 14))
        listCategory.append(CategoryModel(nameCategory: "Award", typeCategory: 2, iconCategory: "ic_category_award", idCategory: 15))
        listCategory.append(CategoryModel(nameCategory: "Interest Money", typeCategory: 2, iconCategory: "ic_category_interestmoney", idCategory: 16))
        listCategory.append(CategoryModel(nameCategory: "Salary", typeCategory: 2, iconCategory: "icon_36", idCategory: 17))
        listCategory.append(CategoryModel(nameCategory: "Gifts", typeCategory: 2, iconCategory: "icon_66", idCategory: 18))
    }
}
