//
//  ViewController.swift
//  ScrollView
//
//  Created by Devere Weaver on 12/25/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var contentView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        /* register this ViewController object as a Notification Center observer to receive notifications */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)),
                                               name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        /* TODO: Go through this code later and figure out wtf is going on
         * Adjust the screen size when the keyboard is shown while user is entering information
         */
        guard let info = notification.userInfo,
              let keyboardFramevalue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardFramevalue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        // content inset is used to change the size of the content area of the scroll view
        contentView.contentInset = contentInsets
        
        // prevent scroll indicators for incorrect placement
        contentView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        /* Reset the content view (scroll view) back when the keyboard is dismissed */
        let contentInsets = UIEdgeInsets.zero
        contentView.contentInset = contentInsets
        contentView.verticalScrollIndicatorInsets = contentInsets
    }


}

