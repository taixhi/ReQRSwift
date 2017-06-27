//
//  DisplayController.swift
//  ReQRScan
//
//  Created by 加藤 太一 on 2017/06/27.
//  Copyright © 2017 Team Lab Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class DisplayController: UIViewController {
    @IBOutlet weak var retrieveButton: UIButton!
    private let disposebag = DisposeBag()
    private var observable: Observable<String?>? = nil
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var QRString: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpQR()
        setUpObservable()
        bind()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setUpObservable() {
        QRString.text = "hello!"
        observable = QRString.rx.text.asObservable()
        observable?.subscribe(onNext: {(input: String?) in
                self.setUpQR(string: input!)
            })
    }
    private func setUpQR(string: String = "hello!") {
        var qrCode = QRCode(string)
        qrCode?.size = CGSize(width: 1000, height: 1000)
        imageView.image = qrCode?.image
    }
    private func bind(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event
            .subscribe(onNext: {tapGesture in
                self.view.endEditing(true)
                return
            }).addDisposableTo(disposebag)
        view.addGestureRecognizer(tapGesture)
        
        close.rx.tap
            .subscribe(onNext: {[unowned self] in
                self.dismiss(animated: true, completion: nil)
            }).addDisposableTo(disposebag)
        retrieve.rx.tap
            .subscribe(onNext: {
               let _ = mockAPI()
                return
            })
    }
    private func mockAPI(){
        sleep(2)
        return QRInfo()
    }
    class QRInfo{
        let typeCode: String?
        let price: String?
        let companyCode = "0000"
        let expiryDate : String?
        let outletCode : String?
        let others : String?
        init() {
            typeCode = "PPP"
            price = "0100"
            companyCode = "0000"
            expiryDate = "170904"
            outletCode = "TTTT"
            others = "XXXXXX"
        }
        func qrString() -> String {
            guard let string = (typeCode? + price? + companyCode + expiryDate? + outletCode? + others?) else {return ""}
            return string
        }
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
