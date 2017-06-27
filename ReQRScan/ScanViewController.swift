//
//  ScanViewController.swift
//  ReQRScan
//
//  Created by 加藤 太一 on 2017/06/27.
//  Copyright © 2017 Team Lab Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController/*, AVCaptureMetadataOutputObjectsDelegate*/ {
    var session: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        
//        super.viewDidLoad()
//        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//        
//        do {
//            let input = try AVCaptureDeviceInput(device: device)
//            session = AVCaptureSession()
//        }
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
