//
//  logininViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/6/28.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class logininViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton()
        btn.addTarget(self, action:#selector(self.nextView), for: .touchUpInside)

        btn.frame = CGRect(x: view.frame.size.width/2 - 40, y: view.frame.size.height/2 - 40, width: 80, height: 80)
        btn.setTitle("登入", for: .normal)
        btn.backgroundColor = UIColor.black
        btn.setTitleColor(UIColor.white, for: .normal)
        
        view.addSubview(btn)
        view.backgroundColor = UIColor.white

    }
    
    @objc func nextView() {
        
        let vc = phoneNumberViewController()
        self.navigationController?.pushViewController(vc, animated: true)


    }

    
}

