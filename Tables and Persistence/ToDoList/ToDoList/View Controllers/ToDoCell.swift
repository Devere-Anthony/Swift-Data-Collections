import UIKit

protocol ToDoCellDelegate: AnyObject {
    /* This protocol is used to let the implementing class know the cell's checkmark
     * button has been tapped so it can make the necessary updates to the model. */
    func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    /* A customized table cell to allow for quick workflow edits. This will be implemented by using custom
     * controls that enable these quick updates. The reason we want to use this standalone class is for
     * separation of concerns, we don't want one view controller to be responsible for multiple things. */
    
//==============================================================================
// MARK: View Controller Properties
//==============================================================================
    // Keep a reference of its delegate.
    weak var delegate: ToDoCellDelegate?
    
//==============================================================================
// MARK: View Controller Methods
//==============================================================================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//==============================================================================
// MARK: Interface Builder Outlets
//==============================================================================
    @IBOutlet var isCompletedButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
//==============================================================================
// MARK: Interface Builder Actions
//==============================================================================
    @IBAction func completeButtonTapped(_ sender: Any) {
        /* When the button is tapped, inform the delegate that the button tap has
         * occurred. */
        
        // Recall, we do this by invoking the delegate's implemented delegate method
        // which will give the delegate access to this cell's data. 
        delegate?.checkmarkTapped(sender: self)
    }
    
   
}
