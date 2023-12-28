/* EmojiTableViewCell.swift - contain the implmenetation of a
 * EmojiTableViewCell class that is responsible for updating the
 * visual aspects of the cells in My Table View
 */

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    // The outlets we want to visually update
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func update(with emoji: Emoji) {
        /* take an Emoji instance and use it to update the cell's labels appropriately,
         * this moves the visual cell updating code from the table view controller into
         * this table cell view controller and avoids all of the weirdness that goes
         * along with it 
         */
        symbolLabel.text = emoji.symbol
        descriptionLabel.text = emoji.description
        nameLabel.text = emoji.name
    }

}
