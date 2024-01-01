//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Devere Weaver on 12/26/23.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
//==============================================================================
// MARK: Outlets
//==============================================================================
    @IBOutlet var myTableView: UITableView!
    
//==============================================================================
// MARK: Properties
//==============================================================================
    var emojis: [Emoji] = []
    
//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calculate cell heigh based on content w/average cell
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // Check to see if exiting Emoji is on disk, if not then use samples.
        if let existingEmojis = Emoji.loadFromFile() {
            emojis = existingEmojis
        } else {
            emojis = Emoji.sampleEmojis()
        }
    }
    
    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        /* Define which table view is returned based on waht was tapped by the user. */
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let emojiToEdit = emojis[indexPath.row]
            return AddEditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
        } else {
            return AddEditEmojiTableViewController(coder: coder, emoji: nil)
        }
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        /* Return to the Emoji table view based on if the save button was pushed or
         * if the cancel button was pushed.
         */
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source
                as? AddEditEmojiTableViewController,
              let emoji = sourceViewController.emoji else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        Emoji.saveToFile(emojis: emojis)
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        /* Enable editing of the table view. */
        let tableViewEditingMode = myTableView.isEditing
        myTableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        /* determine the editing style of the cells */
        return .delete
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /* reload the data source each time a user returns to the table */
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
//==============================================================================
// MARK: Data Source Methods
//==============================================================================
    override func numberOfSections(in tableView: UITableView) -> Int {
        /* Return the number of sections for the table. */
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Return the number of rows for each section in the table. */
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Configure the cell to display information about the model object. */
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        let emoji = emojis[indexPath.row]
        cell.update(with: emoji)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /* Override to support editing in the table view. */
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Emoji.saveToFile(emojis: emojis)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        /* Move the rows around in editing mode. */
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        Emoji.saveToFile(emojis: emojis)
    }
    
}  // end of class
