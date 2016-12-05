//
//  DetailCategoryViewController.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/4/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class DetailCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var category: Category?
    let listCell = ListCellViewDetailCategory()
    var categoryManager = CategoryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if category?.type != 0 {
            let buttonEdit = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(editAction))
            navigationItem.rightBarButtonItem = buttonEdit
        }
    }
    
    @objc private func editAction() {
        if let addCategory = self.storyboard?.instantiateViewControllerWithIdentifier("AddCategoryViewController") as? AddCategoryViewController {
            let navController = UINavigationController(rootViewController: addCategory)
            addCategory.delegate = self
            addCategory.category = category
            self.presentViewController(navController, animated:true, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print(category?.name)
    }
}

extension DetailCategoryViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCell.listCellViewDetailCategory.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let viewDetailCategory = listCell.listCellViewDetailCategory[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(viewDetailCategory.cellIdentifier, forIndexPath: indexPath)
        configCell(cell)
        return cell
    }
    
    private func configCell(cell: UITableViewCell) {
        if let categories = category {
            switch cell {
            case let cell as NameCategoryCell:
                cell.configCellWithContent(categories)
                
            case let cell as TypeCategoryCell:
                cell.configCellWithContent(categories)
            default:
                break
            }
        }
    }
}

extension DetailCategoryViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let dataCell = listCell.listCellViewDetailCategory[indexPath.row]
        if category?.type == 0 {
            if dataCell.cellIdentifier == "deleteCell" {
                return 0.0
            }
        }
        return dataCell.heighForCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension DetailCategoryViewController: SaveCategory {
    func didSaveCategory(category: CategoryModel) {
        self.category?.name = category.nameCategory
        self.category?.icon = category.iconCategory
        self.category?.type = category.typeCategory
        self.category?.idCategory = category.idCategory
        self.tableView?.reloadData()
    }
}
