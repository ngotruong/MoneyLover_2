//
//  DetailCategoryViewController.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/4/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

protocol DeleteCategory: class {
    func didDeleteCategory(category: Category)
}

class DetailCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var category: Category?
    let listCell = ListCellViewDetailCategory()
    var categoryManager = CategoryManager()
    weak var delegate: DeleteCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonEdit = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: #selector(editAction))
        navigationItem.rightBarButtonItem = buttonEdit
    }
    
    @objc private func editAction() {
        if let addCategory = self.storyboard?.instantiateViewControllerWithIdentifier("AddCategoryViewController") as? AddCategoryViewController {
            //            addCategory.delegate = self
            let navController = UINavigationController(rootViewController: addCategory)
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
        return dataCell.heighForCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let viewDetailCategory = listCell.listCellViewDetailCategory[indexPath.row]
        if viewDetailCategory.cellIdentifier == "deleteCell" {
            if let idCategory = category?.idCategory as? Int {
                if categoryManager.deleteCategory(idCategory) {
                    if let oldCategory = category {
                        self.delegate?.didDeleteCategory(oldCategory)
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
            }
        }
    }
}

//extension DetailCategoryViewController: SaveCategory {
//    func didSaveCategory(category: Category) {
//        self.category = category
//        self.tableView?.reloadData()
//    }
//}
