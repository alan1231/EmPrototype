//
//  ExchangeViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/8/20.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
        let getExRate =  UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "换汇"
        view.backgroundColor = UIColor.white
        
        getExRate.frame = CGRect(x: viewSize.width/20, y: viewSize.height/10 + (viewSize.width/17), width: viewSize.width/1.9 - (viewSize.width/20*2), height: viewSize.height/8)
        getExRate.backgroundColor = UIColor.groupTableViewBackground
        getExRate.addTarget(self, action: #selector(self._getExRate), for: .touchUpInside)
        getExRate.setTitle("取得匯率", for: .normal)
        getExRate.layer.cornerRadius = 5
        getExRate.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(getExRate)
        
    }
    @objc func _getExRate(){
//        let vc = SWQRCodeViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        APIManager.getApi.getExRate(completion:{
            result in
            result?.forEach({ (key, value) in
                print("\(key)\(value)")
            })
        })

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
