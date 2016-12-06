//
//  DetailCategoryViewController.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/4/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

protocol DeleteCategoryDelegate: class {
    func didDeleteCategory(indexPath: NSIndexPath?)
}

class DetailCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var category: CategoryModel?
    let listCell = ListCellViewDetailCategory()
    var categoryManager = CategoryManager()
    weak var delegate: DeleteCategoryDelegate?
    var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(category?.typeCategory)
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
        if let cell = tableView.dequeueReusableCellWithIdentifier(viewDetailCategory.cellIdentifier, forIndexPath: indexPath) as? ConfigCell {
            if let category = category {
                cell.configCellWithContent(category)
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension DetailCategoryViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let dataCell = listCell.listCellViewDetailCategory[indexPath.row]
        if let category = category {
            if dataCell.cellIdentifier == "deleteCell" && category.typeCategory == 0 {
                return 0.0
            }
        }
        return dataCell.heighForCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let viewDetailCategory = listCell.listCellViewDetailCategory[indexPath.row]
        if viewDetailCategory.cellIdentifier == "deleteCell" {
            let alertController = UIAlertController(title: NSLocalizedString("DeleteTitle", comment: ""), message: NSLocalizedString("MessageDeleteTransaction", comment: ""), preferredStyle: .Alert)
            let logoutAction = UIAlertAction(title: NSLocalizedString("ButtonConfirmDelete", comment: ""), style: .Default) { (logoutaction) in
                if let idCategory = self.category?.idCategory {
                    if self.categoryManager.deleteCategory(idCategory) {
                        self.delegate?.didDeleteCategory(self.indexPath)
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
            }
            alertController.addAction(logoutAction)
            let cancelAction = UIAlertAction(title: NSLocalizedString("ButtonTitleCancel", comment: ""), style: .Default, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}

extension DetailCategoryViewController: SaveCategoryDelegate {
    func didSaveCategory(category: CategoryModel) {
        self.category = category
        self.tableView?.reloadData()
    }
}
