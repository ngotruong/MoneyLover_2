//
//  AddTransactionViewController.swift
//  MoneyLover
//
//  Created by Ngo Sy Truong on 11/28/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

class AddTransactionViewController: UITableViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Transaction"
        let buttonSave = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(saveAction))
        let buttonCancel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(cancelAction))
        navigationItem.rightBarButtonItem = buttonSave
        navigationItem.leftBarButtonItem = buttonCancel
        self.navigationController?.navigationBar.tintColor = UIColor.greenColor()
        self.dateLabel?.text = getDateCurrent()
    }
    
    @objc private func saveAction() {
    }
    
    @objc private func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowCategoryViewController" {
            let backItem = UIBarButtonItem()
            backItem.title = "Back"
            navigationItem.backBarButtonItem = backItem
        } else if segue.identifier == "NoteViewController" {
            if let noteViewController = segue.destinationViewController as? NoteViewController {
                noteViewController.delegate = self
            }
        }
    }
    
    private func getDateCurrent() -> String {
        let date = NSDate()
        return "\(date.weekDay), \(date.day) \(date.month) \(date.year)"
    }
}

extension AddTransactionViewController: DataNote {
    func didInputNote(string: String) {
        noteLabel?.textColor = UIColor.blackColor()
        noteLabel?.text = string
    }
}
