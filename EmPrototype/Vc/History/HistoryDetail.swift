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
    var detail : Receipts!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = "detail"
        
        let outflowType = UILabel()
        outflowType.frame = CGRect(x: 0, y: view.frame.height/12, width: view.frame.width, height: 40)
        outflowType.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(outflowType)
        
        let toUserId = detail.txresult!.outflow!  ? detail.txparams?.receiver:detail.txparams?.sender
        
        UserBank.get(userId: toUserId!){user in
            switch (self.detail.txType!)
            {
            case 1:
                print(1)
            //                    txType.text = " 此筆紀錄 : " + "存款"
            case 2:
                print(2)
            //                    txType.text = " 此筆紀錄 : " + "提款"
            case 3:
                let b = self.detail.txresult!.outflow!  ? "付款":"收款"
                outflowType.text = b

            case 4:
//                let signForm = CurrencySign[self.detail.txparams!.currency!]!
//                let signTo = CurrencySign[self.detail.txparams!.toCurrency!]!
                let str = "換匯-"+(self.detail.txparams?.currency)!+"→"+(self.detail.txparams?.toCurrency)!
                outflowType.text  = str
//                cell.imgView.image = UIImage(named: "ExchangeIcon")
//                cell.imgView.clipsToBounds = false
//                cell.imgView.contentMode = UIView.ContentMode.scaleAspectFit
//                cell.examount.text = signForm + " \(dic.txparams!.amount!) → " + signTo + " \(dic.txresult!.amount!)"
//                cell.exchange.text = "1 " + "\(dic.currency!)" + " = " + "\(dic.txresult!.amount! / dic.txparams!.amount! )"
            default:
                break
            }
        }
        
        
        

        
        
        let datetime = UILabel()
        datetime.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: 20)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let yyyymm = dateFormatter.string(from:detail!.datetime_!)
        datetime.text = " 日期 : " + yyyymm
        
        view.addSubview(datetime)
        
        let currency = UILabel()
        currency.frame = CGRect(x: 0, y: 170, width: view.frame.width, height: 20)
        currency.text = " 幣別 : " + (detail?.currency)!
        view.addSubview(currency)
        
        let message = UILabel()
        message.frame = CGRect(x: 0, y: 190, width: view.frame.width, height: 20)
        message.text = " message : " + (detail?.message)!
        view.addSubview(message)
        
        let statusCode = UILabel()
        statusCode.frame = CGRect(x: 0, y: 210, width: view.frame.width, height: 20)
        let status = (detail?.statusCode)! == 0 ? "完成" : "未完成"
        statusCode.text = " 交易狀態 : " + status
        view.addSubview(statusCode)
        
        let txType = UILabel()
        txType.frame = CGRect(x: 0, y: 230, width: view.frame.width, height: 20)
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
        
        let outflow = UILabel()
        outflow.frame = CGRect(x: 0, y: 250, width: view.frame.width, height: 20)
        let b = detail?.txresult!.outflow == false ? "入帳":"出帳"
        outflow.text = " 出入帳 : " + b
        view.addSubview(outflow)
        let receiver = UILabel()
        receiver.frame = CGRect(x: 0, y: 270, width: view.frame.width, height: 20)
        let str = user.get("username") == (detail?.txparams!.sender!) ? "付款人" : "收款人"
        let str2 = str == "收款人" ? (detail?.txparams!.receiver)! : (detail?.txparams!.sender)!
        receiver.text = " \(str) : " + (UserBank.dict[str2]!?.name!)!
        view.addSubview(receiver)
                
        let amount = UILabel()
        amount.frame = CGRect(x: 0, y: 290, width: view.frame.width, height: 20)
        amount.text = " 交易金額 : " + "\(detail!.txparams!.amount!)"
        view.addSubview(amount)
        
        let balance = UILabel()
        balance.frame = CGRect(x: 0, y: 310, width: view.frame.width, height: 20)
        balance.text = " 剩餘餘額 : " + "\(detail!.txresult!.balance!)"
        view.addSubview(balance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
