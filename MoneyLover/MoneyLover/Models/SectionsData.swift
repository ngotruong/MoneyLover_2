//
//  SectionsData.swift
//  E-LearningSystem
//
//  Created by Nguyễn Tiến Mạnh on 11/16/16.
//  Copyright © 2016 Ngo Sy Truong. All rights reserved.
//

import UIKit

struct Section {
    var title = ""
    var listCategory = [Category]()
    
    init(title: String, listCategory: [Category]) {
        self.title = title
        self.listCategory = listCategory
    }
}

class SectionsData {
    func getSectionsFromData(dictCategory: [Int: [Category]]) -> [Section] {
        var sectionsArray = [Section]()
        for (key, value) in dictCategory {
            if key == 0 {
                let section = Section(title: "DEPT/LOAN", listCategory: value)
                sectionsArray.append(section)
            } else if key == 1 {
                let section = Section(title: "EXPENSE", listCategory: value)
                sectionsArray.append(section)
            } else {
                let section = Section(title: "INCOME", listCategory: value)
                sectionsArray.append(section)
            }
        }
        return sectionsArray
    }
}
