//
//  homeViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {
    var homeMain : homeLayoutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeMain = homeLayoutView(frame: self.view.frame, VC: self)
        view.addSubview(homeMain)
        
        view.backgroundColor = mobiColor
        navigationController?.navigationBar.isHidden = true
        
        homeMain.FiatBtn.addTarget(self, action: #selector(self.fiat), for: .touchUpInside)
        homeMain.CryptoBtn.addTarget(self, action: #selector(self.Crypto), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc func fiat (){
        homeMain.pageview.setContentOffset(CGPoint(x:homeMain.pageview.frame.width, y: 0), animated: true)
    }
    @objc func Crypto (){
        homeMain.pageview.setContentOffset(CGPoint(x:0, y: 0), animated: true)
    }

}
