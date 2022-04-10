import UIKit

class NewTableViewCell: UITableViewCell {

    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var newAuthor: UILabel!
    @IBOutlet weak var newDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
