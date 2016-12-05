//
//  DetailCategoryViewController.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/4/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

protocol DeleteCategory: class {
    func didDeleteCategory(indexPath: NSIndexPath?)
}

class DetailCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var category: CategoryModel?
    let listCell = ListCellViewDetailCategory()
    var categoryManager = CategoryManager()
    weak var delegate: DeleteCategory?
    var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if category?.typeCategory != 0 {
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
        if let category = category {
            switch cell {
            case let cell as NameCategoryCell:
                cell.configCellWithContent(category)
            case let cell as TypeCategoryCell:
                cell.configCellWithContent(category)
            default:
                break
            }
        }
    }
}

extension DetailCategoryViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let dataCell = listCell.listCellViewDetailCategory[indexPath.row]
        if category?.typeCategory == 0 {
            if dataCell.cellIdentifier == "deleteCell" {
                return 0.0
            }
        }
        return dataCell.heighForCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let viewDetailCategory = listCell.listCellViewDetailCategory[indexPath.row]
        if viewDetailCategory.cellIdentifier == "deleteCell" {
            if let idCategory = category?.idCategory {
                if categoryManager.deleteCategory(idCategory) {
                    self.delegate?.didDeleteCategory(self.indexPath)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
        }
    }
}

extension DetailCategoryViewController: SaveCategory {
    func didSaveCategory(category: CategoryModel) {
        self.category = category
        let listCategoryAvailable = ListCategoryAvailable()
        for categoryModel in listCategoryAvailable.listCategory {
            if category.idCategory == categoryModel.idCategory {
                categoryModel.iconCategory = category.iconCategory
                categoryModel.nameCategory = category.nameCategory
                categoryModel.typeCategory = category.typeCategory
            }
        }
        self.tableView?.reloadData()
    }
}
