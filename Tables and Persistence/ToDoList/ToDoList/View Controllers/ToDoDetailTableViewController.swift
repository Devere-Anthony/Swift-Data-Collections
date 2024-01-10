import UIKit

class ToDoDetailTableViewController: UITableViewController  {
    /* The ToDoDetailTableViewController is responisble for controlling the appearance of
     * the view that adds a new To-Do object. */
    
    // TODO: Figure out how to dismiss the keyboard in the textview (text field is implemented).
    
//==============================================================================
// MARK: View Controller Properties
//==============================================================================
    var isDatePickerHidden = true
    let datePickerLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let datePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewCellIndexPath = IndexPath(row: 0, section: 2)

//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the UI elements.
        dueDatePicker.date = Date().addingTimeInterval(3600)
        updateDueDateLabel(date: dueDatePicker.date)
        updateSaveButton()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /* Hide the date picker initially. */
        if indexPath == datePickerCellIndexPath && isDatePickerHidden == true {
            return 0
        } else if indexPath == notesTextViewCellIndexPath {
            return 200
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        /* Provide an estimated height for the rows...but why is this necessary? */
        switch indexPath {
        case datePickerCellIndexPath: 
            return 216
        case notesTextViewCellIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Respond to the user tapping the date picker to expand/hide it. */
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == datePickerLabelCellIndexPath {
            isDatePickerHidden.toggle()
            updateDueDateLabel(date: dueDatePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func updateSaveButton() {
        /* Update the state of the save button based on validity of the user input. */
        
        // As of now, the only input that needs to be checked is the text field for the title. 
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
    func updateDueDateLabel(date: Date) {
        /* Update the due date label. */
        dueDateLabel.text = date.formatted(.dateTime.month(.abbreviated).day().year().hour().minute())
    }
    
//==============================================================================
// MARK: Interface Builder Outlets
//==============================================================================
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
//==============================================================================
// MARK: Interface Builder Actions
//==============================================================================
    @IBAction func updateTextField(_ sender: UITextField) {
        /* Update the state of the save button with each edit of the text field. */
        updateSaveButton()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        /* Dismiss the keyboard from the view when the return key is tapped. */
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        /* Change the state of the button based on if the task is complete or not. */
        isCompleteButton.isSelected.toggle()
    }
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        /* Update the due date label to reflect the date picker date. */
        updateDueDateLabel(date: sender.date)
    }
    
}    // end of class
