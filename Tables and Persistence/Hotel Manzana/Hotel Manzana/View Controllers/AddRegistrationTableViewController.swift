//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Devere Weaver on 1/3/24.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
//==============================================================================
// MARK: Class Properties
//==============================================================================
    // Store the index path  for the two date picker objects.
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)

    // Initialize the date pickers to be hidden from the user. Change the
    // the visibility state as the user interacts with the elements in the
    // scene (the body of the computed variable changes its state).
    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var isCheckOutDatePickerVisible: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    // Store the index path for check-in and check-out rows.
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
   
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /* Adjust the height of the date picker cells based on which date picker was
         * selected and their current visibility. If the selected date picker is hidden
         * then collapse their row heights. Keep all the other remaing rows at a default
         * row height to present to the user. */
        switch indexPath {
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
            return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        /* Estimate the row size for the date pickers. This will be needed to set the amount of space they'll
         * need on the scene when they become visible after user interaction. */
        switch indexPath {
        case checkInDatePickerCellIndexPath: return 190
        case checkOutDatePickerCellIndexPath: return 190
        default: return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Toggle the visibility of the check-in and check-out date pickers. */
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
            // Check-in selected & Check-out hidden => Expand check-in
            isCheckInDatePickerVisible.toggle()
        } else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false{
            // Check-out select & Check-in hidden => Expand check-out
            isCheckOutDatePickerVisible.toggle()
        } else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
            // Either one selected => Expand the selected and hide the other one
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        } else {
            return
        }
        
        // Instruct the table view to update itself and recalculate row heights.
        tableView.beginUpdates()
        tableView.endUpdates()
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
