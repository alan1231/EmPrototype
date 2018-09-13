//
//  HistoryDetail.swift
//  EmPrototype
//
//  Created by alan on 2018/9/11.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import ObjectMapper

class HistoryDetail: UIViewController {
    var detail : Receipts?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "detail"
        let datetime = UILabel()
        datetime.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: 20)
        datetime.text = " 日期 : " + (detail?.datetime)!
        view.addSubview(datetime)
        
        let currency = UILabel()
        currency.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 40)
        currency.text = " 幣別 : " + (detail?.currency)!
        view.addSubview(currency)
        
        let message = UILabel()
        message.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: 60)
        message.text = " message : " + (detail?.message)!
        view.addSubview(message)
        
        let statusCode = UILabel()
        statusCode.frame = CGRect(x: 0, y: 140, width: view.frame.width, height: 80)
        let status = (detail?.statusCode)! == 0 ? "完成" : "未完成"
        statusCode.text = " 交易狀態 : " + status
        view.addSubview(statusCode)
        
        let txType = UILabel()
        txType.frame = CGRect(x: 0, y: 160, width: view.frame.width, height: 100)
        switch (detail!.txType!)
        {
        case 1:
            txType.text = " 此筆紀錄 : " + "存款"
        case 2:
            txType.text = " 此筆紀錄 : " + "提款"
        case 3:
            txType.text = " 此筆紀錄 : " + "轉帳"
        case 4:
            txType.text = " 此筆紀錄 : " + "換匯"
        default:
            break
        }
        view.addSubview(txType)
        
        let receiver = UILabel()
        receiver.frame = CGRect(x: 0, y: 180, width: view.frame.width, height: 120)
        let str = user.get("username") == (detail?.txparams!.sender!) ? "付款人" : "收款人"
        let str2 = str == "收款人" ? (detail?.txparams!.receiver)! : (detail?.txparams!.sender)!
        receiver.text = " \(str) : " + str2
        view.addSubview(receiver)
                
        let amount = UILabel()
        amount.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 140)
        amount.text = " 交易金額 : " + "\(detail!.txparams!.amount!)"
        view.addSubview(amount)
        
        let balance = UILabel()
        balance.frame = CGRect(x: 0, y: 220, width: view.frame.width, height: 160)
        balance.text = " 剩餘餘額 : " + "\(detail!.txresult!.balance!)"
        view.addSubview(balance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
