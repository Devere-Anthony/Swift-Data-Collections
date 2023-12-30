//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Devere Weaver on 12/26/23.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    /* This UITableViewController subclass will be used as both the table view's data
     * source and the view delegate. Here they are the same and it does happen often
     * when dealing with table views; however, this isn't always the case.
     */

    @IBOutlet var myTableView: UITableView!
    
    // array of Emojis where each Emoji entry will be displayed in an individual row in the table view
    var emojis: [Emoji] = [
           Emoji(symbol: "😀", name: "Grinning Face", 
                 description: "A typical smiley face.", usage: "happiness"),
           Emoji(symbol: "😕", name: "Confused Face", 
                 description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
           Emoji(symbol: "😍", name: "Heart Eyes",
                 description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
           Emoji(symbol: "🧑‍💻", name: "Developer", 
                 description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).",
                 usage: "apps, software, programming"),
           Emoji(symbol: "🐢", name: "Turtle", 
                 description: "A cute turtle.", usage: "something slow"),
           Emoji(symbol: "🐘", name: "Elephant",
                 description:"A gray elephant.", usage: "good memory"),
           Emoji(symbol: "🍝", name: "Spaghetti",
           description: "A plate of spaghetti.", usage: "spaghetti"),
           Emoji(symbol: "🎲", name: "Die",
                 description: "A single die.", usage: "taking a risk, chance; game"),
           Emoji(symbol: "⛺️", name: "Tent",
                 description: "A small tent.", usage: "camping"),
           Emoji(symbol: "📚", name: "Stack of Books",
                 description: "Three colored books stacked on each other.", usage: "homework, studying"),
           Emoji(symbol: "💔", name: "Broken Heart",
                 description: "A red, broken heart.", usage: "extremesadness"),
           Emoji(symbol: "💤", name: "Snore",
                 description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
           Emoji(symbol: "🏁", name: "Checkered Flag",
                 description: "A black-and-white checkered flag.", usage: "completion")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    
    // define which table view is returned based on what was tapped by the user
    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        // if the sender is the table view cell...
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let emojiToEdit = emojis[indexPath.row]
            return AddEditEmojiTableViewController(coder: coder, emoji: emojiToEdit)
        } else {
            return AddEditEmojiTableViewController(coder: coder, emoji: nil)
        }
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source           // source view controller is where the segue just came from
                as? AddEditEmojiTableViewController,            // and set it's type to the AddEditEmojiTableViewController subclass
              let emoji = sourceViewController.emoji else {return}     // get the current emoji object from the view where the source came from
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {                                                            // if nil, then we're creating a new emoji
            let newIndexPath = IndexPath(row: emojis.count, section: 0)     // create an index path that references a row within a given section,
            emojis.append(emoji)                                            // basically add another row in the default section
            tableView.insertRows(at: [newIndexPath], with: .automatic)      // insert a cell at the computed index path with automatic animation
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        /* enable editing of the table view */
        
        // get the current editing state of the table view, it will be false
        // before the next line is called initially, and then true after the
        // next line, then so on
        let tableViewEditingMode = myTableView.isEditing
        
        // put the table into editing mode (toggle editing mode of the table view on and off
        myTableView.setEditing(!tableViewEditingMode, animated: true)
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        /* move the data from one row to another row, I suppose this implicitly moves
         * whatever data is in that row as well?...
         * NOTE: It looks like implementing this will automatically add the reorder element to the table
         */
        
        // get the row location of the data to be moved
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        
        // move that data to the new location
        emojis.insert(movedEmoji, at: to.row)
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        /* we'll only have one section for this table view */
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* since we only have one section, the number of rows for this section will be equal to the
         * number of Emoji objects in our array
         *
         * if we had more than one section, we'd need to use conditional logic to figure out which
         * one we're dealing with and from there return the proper number of rows
         */
        return emojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - update the cells using the custom table view cell controller
        // 1. Dequeue cell - return an instance of a UITableViewCell and force-downcast to EmojiTableViewCell
        // to use the custom update method we implemented
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        // 2. Fetch model object to display
        let emoji = emojis[indexPath.row]
        
        // 3. Configure cell - allow for reordering of cells
        cell.update(with: emoji)
        cell.showsReorderControl = true    // redundant since the moving is already implemented above
        
        // 4. Return configured cell
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
/*        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
*/
    }
}
