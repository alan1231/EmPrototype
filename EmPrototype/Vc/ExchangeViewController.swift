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
    
    var keyary = [String]()
    var valueary = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "换汇"
        view.backgroundColor = UIColor.white
        
//        getExRate.frame = CGRect(x: viewSize.width/20, y: viewSize.height/10 + (viewSize.width/17), width: viewSize.width/1.9 - (viewSize.width/20*2), height: viewSize.height/8)
//        getExRate.backgroundColor = UIColor.groupTableViewBackground
//        getExRate.addTarget(self, action: #selector(self._getExRate), for: .touchUpInside)
//        getExRate.setTitle("取得匯率", for: .normal)
//        getExRate.layer.cornerRadius = 5
//        getExRate.setTitleColor(UIColor.black, for: .normal)
//        view.addSubview(getExRate)
        _getExRate()
        
    }
    @objc func _getExRate(){
//        let vc = SWQRCodeViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        APIManager.getApi.getExRate(completion:{
            result in
            result?.forEach({ (key, value) in
                self.keyary.append(key)
                self.valueary.append("\(value)")
            })
//            print(self.keyary.count)
            
            for index in 0...self.keyary.count-1{
                print(index)
                let lab = UILabel()
                lab.frame = CGRect(x: 0, y: 100 + index*30, width: 120, height: 20)
                lab.text = self.keyary[index]
                self.view.addSubview(lab)
                
                let lab2 = UILabel()
                lab2.frame = CGRect(x: 120, y: 100 + index*30, width: 150, height: 20)
                lab2.text = self.valueary[index]
                self.view.addSubview(lab2)
            }
            
            let textview = UITextView()
            textview.frame = CGRect(x: 0, y: 100, width: viewSize.width, height: viewSize.height/2)
            textview.text = "\(result!)"
//            self.view.addSubview(textview)
            
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
