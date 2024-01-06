//
//  SelectRoomTypeTableViewController.swift
//  Hotel Manzana
//
//  Created by Devere Weaver on 1/4/24.
//

import UIKit

/* To pass the user's rooom selection choice back to the main controller, we'll
 need to implement a custom protocol. We'll define a function in this view controller
 that the main view controller will have to implement. This function will give the
 main view controller access to any of the parameters of the function.

 I guess my only question is, why wouldn't something like using the prepare
 function work to send data back to the main controller? */

protocol SelectRoomTypeTableViewControllerDelegate: AnyObject {
    /* Protocol that implements a function to pass user selection information back
     to the primary view controller, SelectRoomTypeTableViewController. */

    // This function will need to be implemented by whatever view controller adopts it. It
    // takes an instance of the SelectRoomTypeTableViewController as well as an instance of
    // that controller's roomType property that is populated based on the user's selection.
    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController,
                                           didSelect roomType: RoomType)
}


class SelectRoomTypeTableViewController: UITableViewController {
    
//==============================================================================
// MARK: View Controller Properties
//==============================================================================
    // Store the selected room type, but it is possible this won't have a value just yet.
    var roomType: RoomType?
    
    // This class will have a property that is a delegate
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?
  
//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//==============================================================================
// MARK: Data Source Methods
//==============================================================================
    override func numberOfSections(in tableView: UITableView) -> Int {
        /* Return the number of sections for the selection table view. */
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Return the number of rows to include all the room types. */
        return RoomType.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Configure each table cell to display information corresponding to a particular element in our
         * data model object array. This will be invoked each time this table loads as well as upon each
         * invocation of tableView.reloadData(), which is called each time the user selects a table row. */
        
        // Get the table cell and get the corresponding element in the RoomType model object.
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        let roomType = RoomType.all[indexPath.row]
        
        // Configure the cell to display the name of each possible room type in the table cells.
        var content = cell.defaultContentConfiguration()
        content.text = roomType.name
        content.secondaryText = "$ \(roomType.price)"
            
        // Add a checkmark next to the selection the user taps.
        if roomType == self.roomType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Store the user's selection into the roomType class property. */
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Assign the room type of the selected row to a local variable so we can use
        // this in the custom delegate method. Then we need to update the class room type
        // property to match.
        let roomType = RoomType.all[indexPath.row]
        self.roomType = roomType
        
        // Call the custom delegate method by passing in the view controller itself along
        // with the local room type variable.
        delegate?.selectRoomTypeTableViewController(self, didSelect: roomType)
        
        // Reload the room selection table to enforce and update to the content of each row. 
        tableView.reloadData()
   }
}
