//
//  RegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Devere Weaver on 1/6/24.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    
//==============================================================================
// MARK: View Controller Properties
//==============================================================================
    var registrations: [Registration] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

//==============================================================================
// MARK: Data Source Methods
//==============================================================================
    override func numberOfSections(in tableView: UITableView) -> Int {
        /* Return the number of sections for the table view. */
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Return the number of rows for the table. This will depend on how many Registration
         * objects are in the registrations array. */
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registrationCell", for: indexPath)
        let registration = registrations[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(registration.firstName) \(registration.lastName)"
        content.secondaryText = "\(registration.checkInDate.formatted(date: .numeric, time: .omitted)) - \(registration.checkOutDate.formatted(date: .numeric, time: .omitted)): \(registration.roomType.name)"
        
        cell.contentConfiguration = content
        return cell
    }
        
    @IBAction func unwindToRegistrationTable(segue: UIStoryboardSegue) {
        /* Get the Registration object created in the AddRegistrationTableViewController
         * and add it to the registrations array so that it can be presented in the
         * registration table cells. */
        
        guard segue.identifier == "unwindToRegistrationTable",
              let sourceViewController = segue.source as? AddRegistrationTableViewController,
              let registration = sourceViewController.registration
        else {return}
        
        registrations.append(registration)
        
        // Don't forget to reload the table data to see the changes.
        tableView.reloadData()
    }
    
    @IBSegueAction func registrationDetails(_ coder: NSCoder, sender: Any?) -> RegistrationDetailsTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let registrationToSend = registrations[indexPath.row]
            return RegistrationDetailsTableViewController(coder: coder, registration: registrationToSend)
        } else {
            return nil
        }
    }
 

    @IBSegueAction func registrationDetailView(_ coder: NSCoder, sender: Any?) -> RegistrationDetailsTableViewController? {
        /* This method is called when the user taps an existing registration entry and wants to see
         * more details about this registration. */
        
        // I need to get the registration the user tapped and then pass that to the initializer for the new view
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let registration = registrations[indexPath.row]
            return RegistrationDetailsTableViewController(coder: coder, registration: registration)
        } else {return nil}
    }
}    // end view controller
