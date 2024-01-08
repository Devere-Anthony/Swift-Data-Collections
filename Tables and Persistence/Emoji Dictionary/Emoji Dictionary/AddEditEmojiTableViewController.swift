//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Devere Weaver on 12/28/23.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
//==============================================================================
// MARK: Properties
//==============================================================================
    var emoji: Emoji?
    
//==============================================================================
// MARK: Outlets
//==============================================================================
    @IBOutlet var symbolTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var usageTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
//==============================================================================
// MARK: View Controller Methods
//==============================================================================
 
    
    required init?(coder: NSCoder) {
        /* Required initializer */
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the title of the view based on if the user is in the
        // editing mode or if the user is in adding mode.
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            title = "Edit Emoji"
        } else {    // Create mode
            title = "Add Emoji"
        }
        
        // Check save button state upon loading view.
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        /* Check to make sure the user entered data into all the text fields
         * before enabling the Save button.
         */
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        
        // Set save button state. This will return false is any of the
        // above constants are empty.
        saveButton.isEnabled = containsSingleEmoji(symbolTextField) &&
        !nameText.isEmpty && !descriptionText.isEmpty &&
        !usageText.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        /* Check the state of the Save button each time a button in the text field
         * is pressed. */
        updateSaveButtonState()
    }
    
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        /* Emoji text fild input validation. */
        guard let text = textField.text, text.count == 1 else {
            return false
        }
        
        let isCombinedIntoEmoji = text.unicodeScalars.count > 1 &&
        text.unicodeScalars.first?.properties.isEmoji ?? false
        let isEmojiPresentation = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        return isEmojiPresentation || isCombinedIntoEmoji
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Save the user's input if the Save button is pressed and then take that input
         * to create a new Emoji object. This Emoji object will be passed to the view
         * the segue is returning to. */
        guard segue.identifier == "saveUnwind" else {return}
        
        let symbol = symbolTextField.text!
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
        if emoji == nil {
            print("Emoji not created")
        } else {
            print("Emoji created.")
        }
    }
}


