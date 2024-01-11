import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    /* The ToDoTableViewController is responsible for controlling the appearance of the
     * "My To-Dos" scene. It will also be responsible for managing the collection of ToDo
     * items by also acting as the data source. */
    
//==============================================================================
// MARK: View Controller Properties
//==============================================================================
    var toDos = [ToDo]()    // collection of ToDo model objects
   
//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Remove the method to populate with dummy objects after testing to make sure our methods work
        // Check for saved data.
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDoTableViewController.populateDummyToDos()
        }
        
        // Add "intelligent" Edit button
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Actions taken when a row is tapped by the user. */
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func checkmarkTapped(sender: ToDoCell) {
        /* Delegate method which will update a model object based on which cell's
         * completed button was tapped. */
        if let indexPath = tableView.indexPath(for: sender) {
            // Assign the matching, existing ToDo to a local variable which we can edit.
            var toDo = toDos[indexPath.row]
            
            // Change the state of this ToDo's isComplete boolean property.
            toDo.isComplete.toggle()
            
            // Assign the updated local ToDo to the same location as the original.
            toDos[indexPath.row] = toDo
            
            // Update this cell's appearance to reflect the state of the button.
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            ToDo.saveToDos(toDos)
        }
    }
    
    
//==============================================================================
// MARK: Interface Builder Actions
//==============================================================================
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        /* Return to this view after saving or cancelling a new ToDo object. This
         * method is also used add the new ToDo object, created in the previous view,
         * to the toDos array. */
        
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! ToDoDetailTableViewController
        
        if let toDo = sourceViewController.toDo {
            // Return the index of the ToDo if it exists in the array already.
            // Recall, it'll do this using the Equitable protocol we implemented earlier.
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo) {
                // If the index is found, simply reassign it with the updated data.
                toDos[indexOfExistingToDo] = toDo
            } else {
                toDos.append(toDo)
            }
        }
        
        tableView.reloadData()
        ToDo.saveToDos(toDos)
    }
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTableViewController? {
        /* Pass the ToDo object to a ToDoDetailTableViewController for editing that corresponds
         * to the cell the user tapped. */
        let detailController = ToDoDetailTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell)
        else {return detailController}
        
        detailController?.toDo = toDos[indexPath.row]
        return detailController
    }
    
//==============================================================================
// MARK: Data Source Methods
//==============================================================================
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Return the number of cells needed for the number of ToDos the user has. */
        return toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Configure the table cells to display the data from each ToDo object in the toDos collection. */
        
        // We want to downcast the cell so that is it an instance of our customized ToDoCell class.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        // After the cell is dequequed, this guy should be that cell's delegate. This means that when
        // out ToDoCell custom cell's completed button is tapped, it will inform this guy that it has
        // been tapped and then go ahead and update the necessary guy in the data collection.
        cell.delegate = self
        
        let toDo = toDos[indexPath.row]
        
        // Since we're using our custom cell, we don't have to get the default cell configuration.
        // Instead, we can simply change these by using the outlet's we created in ToDoCell view.
        cell.titleLabel?.text = toDo.title
        
        // The isComplete property of the ToDo object is used to set the state button
        cell.isCompletedButton.isSelected = toDo.isComplete
        
        return cell
    }

    static func populateDummyToDos() -> [ToDo] {
        /* Populate the toDos array property with simulated data to work with while developing
         * the other features for this project. This is needed until we implement the features to
         * allow the user to enter their own data. */
        let one = ToDo(title: "Complete 'Complex Input Screens'", isComplete: false, dueDate: Date(), notes: "This is pretty complex.")
        let two = ToDo(title: "Start the 'Guided Project: List'", isComplete: false, dueDate: Date() + 1, notes: "This is a lot to take in.")
        let three = ToDo(title: "Complete Shutdown Rituals", isComplete: false, dueDate: Date())
        return [one, two, three]
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        /* Allow for editing of all the table's cells. (Just return true instead of specifying the indexPath. */
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /* Allow for swipe to delete functionality. */
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(toDos)    // Save our data collection anytime the user deletes an object.
        }
    }
}    // end of class
