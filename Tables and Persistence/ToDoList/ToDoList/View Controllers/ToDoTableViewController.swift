import UIKit

class ToDoTableViewController: UITableViewController {
    /* The ToDoTableViewController is responsible for controlling the appearance of the
     * "My To-Dos" scene. It will also be responsible for managing the collection of ToDo
     * items by also acting as the data source. */
    
//==============================================================================
// MARK: View Controller Properties
//==============================================================================
    var toDos = [ToDo]()    // collection of ToDo model objects
   
//==============================================================================
// MARK: Interface Builder Outlets
//==============================================================================
    
//==============================================================================
// MARK: Interface Builder Actions
//==============================================================================

//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check for saved data.
        if let savedToDos = ToDoTableViewController.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDoTableViewController.populateDummyToDos()
        }
        
        // Add "intelligent" Edit button
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        /* Return to this view after saving or cancelling a new ToDo object. */
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let toDo = toDos[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = toDo.title
        cell.contentConfiguration = content
        return cell
    }

    static func loadToDos() -> [ToDo]? {
        /* Retrieve and load an array of ToDo objects from disk. */
        
        // TODO: Implement this method once we're ready to start retrieving/storing data to disk.
        return nil
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
            // Remove the object from the data collection and remove the cell.
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}    // end of class
