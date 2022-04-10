import UIKit
import Alamofire
import SwiftyJSON

class NewsListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=a2198a505fa14e2388fd2ea8124b14b4"
    
    var newsData: [Articles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        fetchNewsData()
    }
    
    func fetchNewsData() {
        DispatchQueue.main.async {
            AF.request(self.url).response { response in
                switch response.result {
                case .success(let data):
                    guard let data = data else { return }
                    self.convertJSON(from: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func convertJSON(from data: Data) {
        do {
            let json = try JSON(data: data)
            json["articles"].array?.forEach({ (new) in
                let new = Articles(author: new["author"].stringValue, title: new["title"].stringValue, description: new["description"].stringValue, publishedAt: dateFromApiString(new["publishedAt"].stringValue)!, url: new["url"].stringValue, urlToImage: new["urlToImage"].stringValue)
                self.newsData.append(new)
            })
            self.tableView.reloadData()
        } catch {
            print("ERROR: \(error)")
        }
    }
    
    func dateFromApiString(_ eventDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: eventDate)
    }
    
    func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 100
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell") as? NewTableViewCell
        cell?.accessoryType = .none
        
        let new = newsData[indexPath.row]
        cell?.newTitle.text = new.title
        cell?.newAuthor.text = new.author
        cell?.newDate.text = dateToString(new.publishedAt)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsNewViewController") as! DetailsNewViewController
        detailsVC.title = "Details of New"
        let index = tableView.indexPathForSelectedRow?.row
        
        let new = newsData[index!]
        detailsVC.imageUrl = new.urlToImage
        detailsVC.detailTitle = new.title
        detailsVC.detailAuthor = new.author
        detailsVC.detailDescription = new.description
        detailsVC.detailDate = dateToString(new.publishedAt)
        detailsVC.articleUrl = new.url
        
        navigationController?.pushViewController(detailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
