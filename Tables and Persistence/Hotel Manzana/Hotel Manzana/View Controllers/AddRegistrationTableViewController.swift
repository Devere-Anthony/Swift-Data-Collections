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
        
        // Initialize the check-in date to always be the current day's date
        // and initialize the check-in date label to match.
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        // Initialize the date labels upon start up.
        updateDateViews()
    }
    
    func updateDateViews() {
        /* Update the detail labels for the check-in and check-out dates to match
         * that of their corresponding date pickers. */
        
        // Prevent guests from checking in and out on the same date.
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        
        // Set the check-in/out labels to match their corresponding date pickers.
        checkInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated,
                                                                 time: .omitted)
        checkOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated,
                                                                   time: .omitted)
    }

//==============================================================================
// MARK: Interface Builder Actions
//==============================================================================
    @IBAction func doneButtonTaped(_ sender: UIBarButtonItem) {
        /* Save the user information and print user input data. */
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
        print("Done Tapped")
        print("first name: \(firstName)")
        print("last name: \(lastName)")
        print("email: \(email)")
        print("Check-in date: \(checkInDate)")
        print("Check-out date: \(checkOutDate)")
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        /* Update the date labels and the minimum check-out date each time the
         * user updates the dates in the DatePickers. */
        updateDateViews()
    }
    
}
