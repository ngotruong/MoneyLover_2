//
//  NameCategoryCell.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/4/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class NameCategoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCellWithContent(category: Category) {
        self.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 25)
        self.textLabel?.text = category.name
        if let iconCategory = category.icon {
            self.imageView?.image = UIImage(named: iconCategory)
        }
    }
}
