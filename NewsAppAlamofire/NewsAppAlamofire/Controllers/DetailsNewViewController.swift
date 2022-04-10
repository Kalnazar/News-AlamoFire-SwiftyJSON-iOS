import UIKit

class DetailsNewViewController: UIViewController {

    var imageUrl: String?
    var detailTitle: String?
    var detailAuthor: String?
    var detailDescription: String?
    var detailDate: String?
    var articleUrl: String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var descriptionNew: UILabel!
    @IBOutlet weak var dateNew: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
        titleDetail.text = detailTitle
        author.text = detailAuthor
        descriptionNew.text = detailDescription
        dateNew.text = detailDate
    }
    
    @IBAction func articleLinkPressed(_ sender: UIButton) {
        if let url = URL(string: articleUrl!) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func loadImage() {
        let url = URL(string: imageUrl!)
        if let data = try? Data(contentsOf: url!) {
            imageView.image = UIImage.init(data: data)
        }
    }

}
