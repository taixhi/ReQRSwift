//
//  ScanViewController.swift
//  ReQRScan
//
//  Created by 加藤 太一 on 2017/06/27.
//  Copyright © 2017 Team Lab Inc. All rights reserved.
//

import UIKit
import AVFoundation
import ReSwift
import RxSwift
import RxCocoa
class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, StoreSubscriber {
    private let disposebag = DisposeBag()
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var scannedLabel: UILabel!
    @IBOutlet weak var enclosedView: UIView!
    var session: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }
    override func viewDidAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }
    override func viewDidDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp() {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            session = AVCaptureSession()
            session?.addInput(input)
            
            let captureOutput = AVCaptureMetadataOutput()
            session?.addOutput(captureOutput)
            captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            session?.startRunning()
            view.bringSubview(toFront: enclosedView)
        } catch {
            return
        }
    }
    private func bind() {
        closeButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: nil)
                
            }).addDisposableTo(disposebag)
    }
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            return
        }
        let meta = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if meta.type == AVMetadataObjectTypeQRCode, let string = meta.stringValue{
            mainStore.dispatch(
                StringScanned(string: string)
            )
        }
    }
    func newState(state: AppState) {
        scannedLabel.text = state.scannedString
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
