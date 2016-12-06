//
//  NoteViewController.swift
//  MoneyLover
//
//  Created by Ngo Truong on 12/5/16.
//  Copyright © 2016 Phùng Tùng. All rights reserved.
//

import UIKit

protocol DataNote: class {
    func didInputNote(string: String)
}

class NoteViewController: UIViewController {
    
    @IBOutlet weak var inputNoteTextView: UITextView!
    weak var delegate: DataNote?
    var noteCurrent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let noteCurrent = noteCurrent {
            inputNoteTextView?.delegate = self
            inputNoteTextView?.text = noteCurrent
            inputNoteTextView?.textColor = UIColor.blackColor()
        } else {
            inputNoteTextView?.delegate = self
            inputNoteTextView?.text = "Enter Note"
            inputNoteTextView?.textColor = UIColor.lightGrayColor()
        }
    }
}

extension NoteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        if inputNoteTextView?.textColor == UIColor.lightGrayColor() {
            inputNoteTextView?.text = nil
            inputNoteTextView?.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        self.delegate?.didInputNote(textView.text)
    }
}
