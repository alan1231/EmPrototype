
//
//  pinCodeViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/6/29.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class CreateWalletViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        self.title = "您已創建過錢包"
        let newBackButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.done, target: self, action:#selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        

        
        
        
        
        let oldBtn = UIButton ()
        oldBtn.frame = CGRect(x: 0, y: view.frame.height/2 - 70, width: view.frame.size.width, height: 70)
        oldBtn.setTitleColor(UIColor.black, for: .normal)
        oldBtn.setTitle("沿用舊錢包", for: .normal)
        oldBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        oldBtn.layer.addBorder(edge: .top, color: UIColor.gray, thickness: 1)
        oldBtn.layer.addBorder(edge: .left, color: UIColor.gray, thickness: 1)
        oldBtn.layer.addBorder(edge: .right, color: UIColor.gray, thickness: 1)
        oldBtn.addTarget(self, action: #selector(self.pinView), for: .touchUpInside)
        view.addSubview(oldBtn)
        
        let oldInfoLab = UILabel()
        oldInfoLab.text = "錢包餘額：Rmb25,000 ; Usd:1000; Btc:40,964 ; Eth:31,451"
        oldInfoLab.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: 20)
        oldInfoLab.font = UIFont.systemFont(ofSize: 10)
        oldInfoLab.textAlignment = .center
        oldBtn.addSubview(oldInfoLab)
        
        
        
        let  newBtn = UIButton ()
        newBtn.frame = CGRect(x: 0, y: view.frame.height/2-1
            , width: view.frame.size.width, height: 70)
        newBtn.layer.borderWidth = 1
        newBtn.setTitleColor(UIColor.black, for: .normal)
        newBtn.setTitle("創建新錢包", for: .normal)
        newBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        
        newBtn.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(newBtn)
    }
    
    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @objc func pinView (){
        let alert = UIAlertController(title: "創建新錢包會讓現有的資料及金錢通通全部遺失", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: { action in
            
            let alert2 = UIAlertController(title: "請再次確定是否創建新錢包", message: nil, preferredStyle: .alert)
            
            alert2.addAction(UIAlertAction(title: "確認", style: .default, handler: { action in
                let vc = pinCodeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }))
            
            self.present(alert2, animated: true)
            
        }))
        
        self.present(alert, animated: true)
        
    }
    
}



