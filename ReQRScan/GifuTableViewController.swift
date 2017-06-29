import UIKit
import RxCocoa
import RxSwift
import Gifu
class GifuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animatedView: GIFImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class GifuTableViewController: UITableViewController{
    @IBOutlet weak var close: UIBarButtonItem!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        close.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            }).addDisposableTo(disposeBag)
        tableView.rx.willDisplayCell
            .subscribe(onNext:{(cell, indexPath) in
                (cell as? GifuTableViewCell)!.animatedView.stopAnimating()
                (cell as? GifuTableViewCell)!.animatedView.animate(withGIFNamed: "gif\(indexPath.row + 1)")
                (cell as? GifuTableViewCell)!.animatedView.contentMode = UIViewContentMode(rawValue: 2)!
            }).addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 49
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gifuCell", for: indexPath) as! GifuTableViewCell
//        cell.animatedView.animate(withGIFNamed: "original.gif")
//        do {
//            cell.animatedView.animator?.stopAnimating()
//        } catch {
//            return cell
//        }
        return cell
    }
}
