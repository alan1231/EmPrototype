//
//  vc222.swift
//  EmPrototype
//
//  Created by alan on 2018/8/15.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Alamofire

class vc222: UIViewController,UITextFieldDelegate {
    var userid = String()
    var username = String()
    var numbertextfiled = UITextField()
//    let message = UITextField()
    let btn = UIButton()
    let lab = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        lab.frame = CGRect(x: 0, y: 150, width: view.frame.width,height: 30)
        lab.text = username
        lab.textAlignment = .center
        view.addSubview(lab)
        
//        message.frame = lab.frame
//        message.frame.origin.y = 190
//        message.frame.origin.x = 50
//        message.frame.size.width = view.frame.width - 100
//        message.attributedPlaceholder = "輸入訊息".attributedString(aligment: .center)
//        message.backgroundColor = UIColor.white
//        view.addSubview(message)
        
        btn.frame = lab.frame
        btn.frame.origin.y = 200
        btn.frame.origin.x = 50
        btn.frame.size.width = view.frame.width - 100
        btn.setTitle("發訊息", for: .normal)
        btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action:#selector(self.send), for: .touchUpInside)
        view.addSubview(btn)
        
        let bb1 = UIButton()
        bb1.frame = lab.frame
        bb1.frame.origin.y = 250
        bb1.frame.origin.x = 50
        bb1.frame.size.width = view.frame.width - 100
        bb1.setTitle("匯款", for: .normal)
        bb1.backgroundColor = UIColor.orange
        bb1.addTarget(self, action:#selector(self.aletview), for: .touchUpInside)
        view.addSubview(bb1)

        
        
        let bb2 = UIButton()
        bb2.frame = lab.frame
        bb2.frame.origin.y = 300
        bb2.frame.origin.x = 50
        bb2.frame.size.width = view.frame.width - 100
        bb2.setTitle("back", for: .normal)
        bb2.backgroundColor = UIColor.orange
        bb2.addTarget(self, action:#selector(self.cc), for: .touchUpInside)
//        view.addSubview(bb2)
        
        
        
    }
    @objc func aletview (){
        
        let actionSheet = UIAlertController(title: "選擇幣別", message: nil, preferredStyle: .actionSheet)
        
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)

        let CNY = UIAlertAction(title: "CNY", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            self.selectNumber("CNY","金額","請輸入金額")
            })
        let USD = UIAlertAction(title: "USD", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            self.selectNumber("USD","金額","請輸入金額")

        })
        let BITCOIN = UIAlertAction(title: "BTC", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            self.selectNumber("BTC","金額","請輸入金額")

        })
        let ETHER = UIAlertAction(title: "ETH", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            self.selectNumber("ETH","金額","請輸入金額")

        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(CNY)
        actionSheet.addAction(USD)
        actionSheet.addAction(BITCOIN)
        actionSheet.addAction(ETHER)
        self.present(actionSheet, animated: true, completion: nil)

    }
    func selectNumber(_ currency:String,_ placeholder:String, _ message:String) {
        // 建立一個提示框
        let alertController = UIAlertController(
            title:currency,
            message: message,
            preferredStyle: .alert)
        
        // 輸入框
        if currency == "推播"{
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = placeholder
                textField.delegate = self
                textField.keyboardType = UIKeyboardType.default
            }
        }else{
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = placeholder
                textField.delegate = self
                textField.keyboardType = UIKeyboardType.decimalPad
            }
            
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "message"
            }
            
        }
        
        // 建立[取消]按鈕
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        alertController.addAction(cancelAction)
        
        // 建立[確定]按鈕
        let okAction = UIAlertAction(
            title: "確定",
            style: UIAlertAction.Style.default) {
                (action: UIAlertAction!) -> Void in
                setupView((self.navigationController?.view)!)

                let acc =
                    (alertController.textFields?.first)!
                        as UITextField
                
                
                if currency == "推播" {
                    APIManager.getApi.sendSingleMessage(self.userid,acc.text!, completion:{
                        result in
                        if result! {
                            stoploadingView()
                        }
                    })
                }else{
                    let message =
                        (alertController.textFields?.last)!
                            as UITextField
                    APIManager.getApi.payBalances(currency, acc.text!, self.userid, message.text!, completion:{
                        result in
                        stoploadingView()
                        
                        //更新
                        APIManager.getApi.getBalances(completion:{
                            balances in
                            let list  = balances!["list"] as! [String:AnyObject]
                            //            print(balances)
                            
                            list.forEach({ (key, value) in
                                CurrencyName.append(key)
                                CurrencyBalance.append("\(value)")
                            })
                
                        })
                        
                        
                    })
                }
                
        }
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(
            alertController,
            animated: true,
            completion: nil)
        }
    
    
    @objc func cc (){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func send (){
        self.selectNumber("推播","","輸入訊息")

//        // 建立一個提示框
//        let alertController = UIAlertController(
//            title:"推播",
//            message: "",
//            preferredStyle: .alert)
//
//        // 輸入框
//        alertController.addTextField {
//            (textField: UITextField!) -> Void in
//            textField.placeholder = "輸入訊息"
//            textField.delegate = self
//
//        }
//
//        // 建立[取消]按鈕
//        let cancelAction = UIAlertAction(
//            title: "取消",
//            style: .cancel,
//            handler: nil)
//        alertController.addAction(cancelAction)
//
//        // 建立[登入]按鈕
//        let okAction = UIAlertAction(
//            title: "確定",
//            style: UIAlertActionStyle.default) {
//                (action: UIAlertAction!) -> Void in
//                setupView(self.view)
//                let acc =
//                    (alertController.textFields?.first)!
//                        as UITextField
////                self.message.resignFirstResponder()
//
//                APIManager.getApi.sendSingleMessage(self.userid,acc.text!, completion:{
//                    result in
//                    if result! {
//                        stoploadingView()
//                    }
//                })
//        }
//        alertController.addAction(okAction)
//
//        // 顯示提示框
//        self.present(
//            alertController,
//            animated: true,
//            completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.placeholder == "金額"{
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let expression = "^\\d{0,10}(\\.\\d{0,8})?$"
            let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
            let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
            return numberOfMatches != 0
        }
        
        return true

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
