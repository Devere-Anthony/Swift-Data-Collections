//
//  RegistrationDetailsTableViewController.swift
//  Hotel Manzana
//
//  Created by Devere Weaver on 1/8/24.
//

import UIKit

class RegistrationDetailsTableViewController: UITableViewController {
    
//==============================================================================
// MARK: View Controller Properties
//==============================================================================
    // MARK: Should this be an optional or should I implement an initializer?
    var registration: Registration!
    
//==============================================================================
// MARK: Interface Outlets
//==============================================================================
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var adultsLabel: UILabel!
    @IBOutlet var childrenLabel: UILabel!
    @IBOutlet var roomNameLabel: UILabel!
    @IBOutlet var roomPriceLabel: UILabel!
    @IBOutlet var wifiLabel: UILabel!
    
    
//==============================================================================
// MARK: Interface Actions
//==============================================================================
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        /* Dismiss the registration details page and return to the registrations
         * table view. */
        dismiss(animated: true, completion: nil)
    }
    
//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    init?(coder: NSCoder, registration: Registration?) {
        /* Custom initializer. */
        self.registration = registration
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        /* Require initializer needed to implement custom one. */
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        /* Update the static cells to contain the information for the Registation
         * object the user selected. */
        firstNameLabel.text = registration.firstName
        lastNameLabel.text = registration.lastName
        emailLabel.text = registration.emailAddress
        checkInDateLabel.text = registration.checkInDate.formatted(date: .abbreviated, time: .omitted)
        checkOutDateLabel.text = registration.checkOutDate.formatted(date: .abbreviated, time: .omitted)
        adultsLabel.text = String(registration.numberOfAdults)
        childrenLabel.text = String(registration.numberOfChildren)
        roomNameLabel.text = registration.roomType.name
        roomPriceLabel.text = "$\(registration.roomType.price)/night"
        
        if registration.wifi {
            wifiLabel.text = "Wifi included."
        } else {
            wifiLabel.text = "No wifi."
        }

    }
}
