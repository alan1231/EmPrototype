//
//  pinCodeAgainViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/6/29.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class pinCodeAgainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        self.title = "再次輸入PIN"
        let newBackButton = UIBarButtonItem(title:nil, style: UIBarButtonItemStyle.done, target: self, action:nil)
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let nextBtn = UIButton()
        nextBtn.frame = CGRect(x: 140, y: 400, width: 100, height: 40)
        nextBtn.addTarget(self, action: #selector(self.nextView), for: .touchUpInside)
        nextBtn.backgroundColor = UIColor.white
        nextBtn.setTitle("確認", for: .normal)
        nextBtn.setTitleColor(UIColor(red: 41/255, green: 125/255, blue: 245/255, alpha: 1), for: .normal)
        view.addSubview(nextBtn)
        
        
    }

        @objc func nextView(){

        
        }

}
