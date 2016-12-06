//
//  DateViewController.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/5/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

protocol ChooseDateDelegate: class {
    func didChooseDate(date: NSDate?)
}

class DateViewController: UIViewController {
    
    weak var delegate: ChooseDateDelegate?
    var dateDidChoose: NSDate?
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker?.datePickerMode = UIDatePickerMode.Date
        if let dateDidChoose = dateDidChoose {
            datePicker?.date = dateDidChoose
        }
    }
    
    @IBAction func chooseDate(sender: AnyObject) {
        if let sender = sender as? UIDatePicker {
            self.delegate?.didChooseDate(sender.date)
        }
    }
}
