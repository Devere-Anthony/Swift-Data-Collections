/* EmojiTableViewCell.swift - contain the implmenetation of a
 * EmojiTableViewCell class that is responsible for updating the
 * visual aspects of the cells in My Table View
 */

import UIKit

class EmojiTableViewCell: UITableViewCell {

//==============================================================================
// MARK: Outlets
//==============================================================================
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func awakeFromNib() {
        /* Built-in initialization code. */
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        /* Configure the view for the cell selected state. */
    }
    
    func update(with emoji: Emoji) {
        /* Take an Emoji instance and use it to update the cell's labels appropriately.
         * This moves the visual cell updating code from the table view controller into
         * this table cell view controller and avoids all of the weirdness that goes
         * along with it.
         *
         * This method is actually invoked in the EmojiTableViewController where the Emoji
         * argument is pass from since this view controller doesn't contain an Emoji instance.
         */
        symbolLabel.text = emoji.symbol
        descriptionLabel.text = emoji.description
        nameLabel.text = emoji.name
    }

}
