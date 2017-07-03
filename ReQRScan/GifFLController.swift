//
//  GifFLController.swift
//  ReQRScan
//
//  Created by Taichi Kato on 2017/06/28.
//  Copyright © 2017年 Team Lab Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class FLTableViewCell: UITableViewCell {
    
    @IBOutlet weak var animatedView: FLAnimatedImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class GifFLController: UITableViewController{
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.willDisplayCell
            .subscribe(onNext:{(cell, indexPath) in
                (cell as? FLTableViewCell)!.animatedView.stopAnimating()
            }).addDisposableTo(disposeBag)
        tableView.rx.didEndScrollingAnimation
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext:{ [unowned self] in
                for i in 0...self.tableView.numberOfRows(inSection: 0){
                    let indexPath = IndexPath(row: i, section: 0)
                    let cellRect = self.tableView.rectForRow(at: indexPath)
                    if self.tableView.bounds.contains(cellRect){
                        print("Start animating path \(i)")
                        (self.tableView.cellForRow(at: indexPath) as? FLTableViewCell)?.animatedView.startAnimating()
                    }else{
                        print("Stop animating path \(i)")
                        (self.tableView.cellForRow(at: indexPath) as? FLTableViewCell)?.animatedView.stopAnimating()
                    }
                }
            }).addDisposableTo(disposeBag)
            // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flCell", for: indexPath) as! FLTableViewCell
        do {
            let image = try FLAnimatedImage(gifData: Data(contentsOf: URL(string: "https://img.gifmagazine.net/gifmagazine/images/932515/original.gif")!))
            cell.animatedView.animatedImage = image
        } catch {
            return cell
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
