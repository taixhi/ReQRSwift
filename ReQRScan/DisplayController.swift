//
//  DisplayController.swift
//  ReQRScan
//
//  Created by 加藤 太一 on 2017/06/27.
//  Copyright © 2017 Team Lab Inc. All rights reserved.
//

import UIKit

class DisplayController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var qrCode = QRCode("Hello TeamLab!")
        qrCode?.size = CGSize(width: 1000, height: 1000)
        imageView.image = qrCode?.image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
