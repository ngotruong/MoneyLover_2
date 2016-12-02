//
//  ListEditViewController.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 12/2/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class ListEditCategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Category"
        let buttonAdd = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = buttonAdd
    }
    
    @objc private func addAction() {
        print("save")
    }
}
