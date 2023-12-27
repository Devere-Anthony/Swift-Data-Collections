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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // programmatically set the margins to be readable
        myTableView.cellLayoutMarginsFollowReadableWidth = true
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
        // 1. ask the table view to dequeue a cell which will return a UITableViewCell instance of the
        // same style that is registered in the Interface Builder - "EmojiCell" identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath)
        
        // 2. get appropriate model object to display in the cell using the indexPath parameter to
        // get the array index required to retrieve the correct Emoji; we only need the row since
        // we only have one section, if we had more, then we'd need to index with the section and the
        // row attributes of the indexPath
        let emoji = emojis[indexPath.row]
        
        // 3. configure the cell to display the model object's data - modify the cell's view
        // to display the emoji information
        var content = cell.defaultContentConfiguration()   // get the cell's configuration type
        content.text = "\(emoji.symbol) - \(emoji.name)"   // make edits to its properties
        content.secondaryText = emoji.description
        cell.contentConfiguration = content                // change the cell's config to the updated one
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
