//
//  homeViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class homeViewController: UIViewController,callBackProtocol {
    func callback(img:UIImage) {
        self.userimg.image = img.toCircle()
    }
    
    var homeMain : homeLayoutView!
    var userimg = UIImageView()
    var username = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeMain = homeLayoutView(frame: self.view.frame, VC: self)
        
        
        APIManager.getApi.getProfile(completion:{
            name,img,err in
            self.userimg.image = UIImage(data: img!)?.toCircle()
            self.username.text = name
        })
        
        view.addSubview(homeMain)
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = false
        self.title = "UWallet"
        
        let newBackButton = UIBarButtonItem(title:"", style: UIBarButtonItemStyle.done, target: self, action:nil)
        self.navigationItem.leftBarButtonItem = newBackButton
        
        let settingButton = UIBarButtonItem(title:"设定", style: UIBarButtonItemStyle.done, target: self, action:#selector(self._setting))
        self.navigationItem.rightBarButtonItem = settingButton
        
        
        homeMain.DepositBtn.addTarget(self, action: #selector(self._Deposit), for: .touchUpInside)
        homeMain.HistoryBtn.addTarget(self, action: #selector(self._History), for: .touchUpInside)
        homeMain.ExchangeBtn.addTarget(self, action: #selector(self._Exchange), for: .touchUpInside)
        homeMain.ReceivePaymentBtn.addTarget(self, action: #selector(self._ReceivePayment), for: .touchUpInside)
        homeMain.BalanceBtn.addTarget(self, action: #selector(self._Balance), for: .touchUpInside)
        
        APIManager.getApi.sendDevicetoken(user.get("DeviceToken"), completion:{
            result in            
        })
        
        userimg.frame = CGRect(x: (viewSize.width/2)-50, y: 80, width: 100, height: 100)


        view.addSubview(userimg)
        username = UILabel()
        username.frame = CGRect(x: 0, y: 190, width: view.frame.width, height: 30)
        username.textAlignment = .center

        view.addSubview(username)
        
     

        
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = false
        
        APIManager.getApi.getBalances(completion:{
            balances in
            balances?.forEach({ (key, value) in
                let str = value["CNY"]!
                self.homeMain.BalanceBtn.setTitle("¥\(str!)", for: .normal)
            })

         
            
        })
    }
    
    
    @objc func _setting (){
        let vc:SettingViewController = SettingViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func _Deposit (){
        let vc = DepositViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func _History (){
        let vc = HistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func _Exchange (){
        let vc = ExchangeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func _ReceivePayment (){
        let vc = ReceivePaymentViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func _Balance (){
        let vc = BalanceViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }

}
