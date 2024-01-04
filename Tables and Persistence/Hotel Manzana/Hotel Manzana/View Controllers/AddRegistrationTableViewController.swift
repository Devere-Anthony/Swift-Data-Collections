//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Devere Weaver on 1/3/24.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
//==============================================================================
// MARK: Interface Builder Outlets
//==============================================================================
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    
    
//==============================================================================
// MARK: View Controller Methods
//==============================================================================

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateDateViews() {
        /* Update the detail labels for the check-in and check-out dates to match
         * that of their corresponding date pickers. */
        
        // TODO: Update the detail label every time the date selected in a date picker changes
    }

//==============================================================================
// MARK: Interface Builder Actions
//==============================================================================
    @IBAction func doneButtonTaped(_ sender: UIBarButtonItem) {
        /* Save the user information and print user input data. */
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        print("Done Tapped")
        print("first name: \(firstName)")
        print("last name: \(lastName)")
        print("email: \(email)")
    }
}
