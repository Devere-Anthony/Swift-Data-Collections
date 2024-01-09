//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Devere Weaver on 1/3/24.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate
{
    
//==============================================================================
// MARK: View Controller Properties
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
    
    // Add a property to hold the selected room type.
    var roomType: RoomType?
    
    // Add a computed property that will return a new Registration? object that we can
    // use to save to our storage system and/or send to a web server for further processing.
    var registration: Registration? {
        // Make sure the roomType is actually set before attempting to create a new model object.
        guard let roomType = roomType else {return nil}
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate,
                            checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren,
                            wifi: hasWifi, roomType: roomType)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Send a newly created Registration object to the Registrations table view. */
        guard segue.identifier == "unwindToRegistrationTable" else {return}
    }
    
    // Properties needed for charges
    var roomTotal: Int!
    var wifiTotal: Int!
    
    
//==============================================================================
// MARK: Interface Builder Outlets
//==============================================================================
    // User input
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!
    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!
    @IBOutlet var wifiSwitch: UISwitch!
    @IBOutlet var roomTypeLabel: UILabel!
    @IBOutlet var doneButton: UIBarButtonItem!
    
    // Charges
    @IBOutlet var numberOfNightsLabel: UILabel!
    @IBOutlet var datesLabel: UILabel!
    @IBOutlet var roomTotalLabel: UILabel!
    @IBOutlet var roomNameAndPriceLabel: UILabel!
    @IBOutlet var wifiTotalLabel: UILabel!
    @IBOutlet var wifiChoiceLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
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
        
        // Set up the number of guests correctly.
        updateNumberOfGuests()
        
        // Initialize the room type label.
        updateRoomType()
        
        // Initialize the Done button to be disabled.
        doneButton.isEnabled = false
        
        // Initialize the number of nights in the charges section.
        updateNumberOfNightsCharges()
        
        // Initialize the wifi charges.
        updateWifiCharges()
        
        // Initialize the labels in the charges section.
        roomTotalLabel.text = "-"
        roomNameAndPriceLabel.text = "-"
        totalLabel.text = "-"
        
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
    
    func updateDoneButton() {
        /* Enable the Done button if the user inputs are valid. */
        
        // Create local variables that store the Registration data.
        let firstNameText = firstNameTextField.text ?? ""
        let lastNameText = lastNameTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let adultsNumber = numberOfAdultsStepper.value
        let roomType = registration?.roomType
        
        // Test if the text fields are empty.
        doneButton.isEnabled = !firstNameText.isEmpty && !lastNameText.isEmpty && !emailText.isEmpty && (adultsNumber >= 1) && (roomType != nil)
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
    
    func updateNumberOfGuests() {
        /* Update the number of adult and/or child guests. Initially this value is called
         * to synchronize the views, after it will be invoked each time one of the stepper
         * UI elements is pressed. */
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType() {
        /* Updates the room type label to match the user selection. */
        
        // Recall, roomType is an optional so we'll need to handle both cases.
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
            updateRoomTypeCharges()
            computeTotal()
        } else {
            roomTypeLabel.text = "Not Set"
            computeTotal()
        }
    }
    
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        /* Required implementation for the selectRoomTypeTableViewController delegate. This
         * implementation will update the room type label based on the user's selection that
         * gets past to it from the SelectRommTypeTableViewController. */
        
        // Here we set the class properties room type to be that of the room type selected
        // by the user from the selection table view. Then we call updateRoomType()
        // which we unwrap the roomType and set it's text accordingly.
        self.roomType = roomType
        updateRoomType()
        updateDoneButton()
    }
    
    func updateNumberOfNightsCharges() {
        /* Dynamically update the information in the Number of Nights row
         * in the charges section of the table. */
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let diff = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate)
        numberOfNightsLabel.text = "\(diff.day ?? 1)"
        datesLabel.text = "\(checkInDate.formatted(date: .abbreviated, time: .omitted)) - \(checkOutDate.formatted(date: .abbreviated, time: .omitted))"
        
        // Update the room total, wifi total, and guest overall total for visit.
        updateRoomTypeCharges()
        updateWifiCharges()
        computeTotal()
    }
    
    func updateRoomTypeCharges() {
        /* Dynamically update the Room Type row in the charges section of the table. */
        
        // Display the total room price (room price * number of nights.
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let diff = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate)
        
        // Unwrap days and price to get the total room price.
        if let days = diff.day,
           let price = roomType?.price {
            roomTotalLabel.text = "$\(days * price)"
            roomTotal = days * price
        }
        
        // Change the subtitle as well
        if let roomName = roomType?.name,
           let roomPrice = roomType?.price {
            roomNameAndPriceLabel.text = "\(roomName) @ $\(roomPrice)/night"
        }
    }
    
    func updateWifiCharges() {
        /* Dynamically update the Wi-Fi related chages in the charges section of the table. */
        
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let diff = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate)
        
        // test if the wifi switch is enabled?
        if wifiSwitch.isOn {
            if let days = diff.day {
                let price = 10
                wifiTotalLabel.text = "$\(days * price)"
                wifiChoiceLabel.text = "Yes"
                wifiTotal = (days * price)
            }
        } else {
            wifiTotalLabel.text = "-"
            wifiChoiceLabel.text = "No"
        }
    }
    
    func computeTotal() {
        /* Compute the total cost for the guest's stay based on their input choices. */
        if let roomTotal = roomTotal {
            totalLabel.text = "$\(roomTotal + wifiTotal)"
        }
    }
//==============================================================================
// MARK: Interface Builder Actions
//==============================================================================
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        /* Update the date labels and the minimum check-out date each time the
         * user updates the dates in the DatePickers. */
        updateDateViews()
        updateNumberOfNightsCharges()
        computeTotal()
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        /* Invoke the updateNumberOfGuests() method each time a stepper value is changed. */
        updateNumberOfGuests()
        updateDoneButton()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        /* TODO: Implement the logic for this later in the challenge section. */
        updateWifiCharges()
        computeTotal()
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        /* Set the delegate property and the roomType property of the selection view if a selection
         * has already been made...?*/
        
        // Create a local variable that stores the selection table view controller that the
        // segue transitions to.
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        
        // Set the delegate property of the selection table view and the room type property as well.
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        
        // Return an instance of the selection table view controller with it's delegate and room type
        // properties set.
        return selectRoomTypeController
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        /* Allow the user to cancel adding a new registration. */
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textFieldUpdated(_ sender: UITextField) {
        /* Check for valid input each time the user updates the text. */
        updateDoneButton()
    }
}
