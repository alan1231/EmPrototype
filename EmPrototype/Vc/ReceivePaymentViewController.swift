//
//  ReceivePaymentViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/8/20.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class ReceivePaymentViewController: UIViewController {
    let QrcodeBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "收付款"
        view.backgroundColor = UIColor.white
        
        QrcodeBtn.frame = CGRect(x: viewSize.width/20, y: viewSize.height/10 + (viewSize.width/17), width: viewSize.width/1.9 - (viewSize.width/20*2), height: viewSize.height/8)
        QrcodeBtn.backgroundColor = UIColor.groupTableViewBackground
        QrcodeBtn.addTarget(self, action: #selector(self._Qrcode), for: .touchUpInside)
        QrcodeBtn.setTitle("Qrcode", for: .normal)
        QrcodeBtn.layer.cornerRadius = 5
        QrcodeBtn.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(QrcodeBtn)
        
        
    }
    @objc func _Qrcode(){
        let vc = SWQRCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
