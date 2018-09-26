//
//  BalanceHistoryLayoutView.swift
//  EmPrototype
//
//  Created by alan on 2018/9/25.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class BalanceHistoryLayoutView: UIView {

    let DepositBtn = UIButton()
    let HistoryBtn = UIButton()
    let ExchangeBtn = UIButton()
    let ReceivePaymentBtn = UIButton()
    let Balanceview = UIView()
    let BalanceActBtn = UIButton()

    let BalanceImgview = UIImageView()
    let Balancelab = UILabel()
    
    let totallab = UILabel()
    let exstrlab = UILabel()
    
    let Balanceimage = UIImageView()
    
    init(frame: CGRect,VC:BalanceHistoryViewController) {
        super.init(frame:frame)
        
        
        Balanceview.frame = CGRect(x:0, y: viewSize.height/11, width: viewSize.width , height: viewSize.height/6)
        self.addSubview(Balanceview)
        BalanceImgview.frame = CGRect(x: Balanceview.frame.width/16, y: Balanceview.frame.height/2 - Balanceview.frame.height/4 , width:Balanceview.frame.size.height/2, height: Balanceview.frame.size.height/2)
        BalanceImgview.image = UIImage(named: "cnycoin")
        BalanceImgview.isUserInteractionEnabled = true
        Balanceview.addSubview(BalanceImgview)
        Balancelab.frame = CGRect(x: BalanceImgview.frame.origin.x + BalanceImgview.frame.size.width , y: Balanceview.frame.height/2 - Balanceview.frame.height/4, width: viewSize.width/1.5, height:Balanceview.frame.size.height/2)
        Balancelab.font = UIFont.boldSystemFont(ofSize: 38)
        Balancelab.textAlignment = .right
        Balancelab.textColor =  UIColor(red: 53/255.0, green: 78/255.0, blue: 81/255.0, alpha: 1)
        Balanceview.addSubview(Balancelab)
        Balancelab.isUserInteractionEnabled = true

        Balanceimage.frame = CGRect(x: Balancelab.frame.origin.x + Balancelab.frame.size.width + 5, y: Balancelab.frame.origin.y + Balancelab.frame.height/2.5, width: viewSize.width/40, height: Balancelab.frame.size.height/4)
        Balanceimage.image = UIImage(named: "Disclosure Indicator")
        Balanceview.addSubview(Balanceimage)
        Balanceimage.isUserInteractionEnabled = true

        exstrlab.frame = CGRect(x: BalanceImgview.frame.origin.x + BalanceImgview.frame.size.width/2, y: BalanceImgview.frame.origin.y + BalanceImgview.frame.size.height  , width: viewSize.width/3, height: viewSize.height/30)
        exstrlab.textColor = UIColor.orange
        exstrlab.isUserInteractionEnabled = true
        Balanceview.addSubview(exstrlab)
        totallab.frame = CGRect(x: exstrlab.frame.origin.x + exstrlab.frame.size.width + 20 , y: exstrlab.frame.origin.y, width: exstrlab.frame.size.width, height: exstrlab.frame.size.height)
        totallab.textColor = UIColor(red: 53/255.0, green: 78/255.0, blue: 81/255.0, alpha: 1)
        totallab.isUserInteractionEnabled = true
        Balanceview.addSubview(totallab)
        
        BalanceActBtn.frame = Balanceview.frame
        self.addSubview(BalanceActBtn)

        
        
        
        ReceivePaymentBtn.frame = CGRect(x: 10, y: Balanceview.frame.origin.y + Balanceview.frame.size.height + 10 , width: viewSize.width - 20, height: viewSize.height/10)
//        ReceivePaymentBtn.setImage(UIImage(named: "Group5"), for: .normal)
        ReceivePaymentBtn.layer.cornerRadius = 10
        ReceivePaymentBtn.backgroundColor = UIColor(red: 53/255.0, green: 78/255.0, blue: 81/255.0, alpha: 1)
        ReceivePaymentBtn.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(ReceivePaymentBtn)
        let ReceivePaymentlab = UILabel()
        ReceivePaymentlab.frame = CGRect(x: ReceivePaymentBtn.frame.width/2, y: ReceivePaymentBtn.frame.height/2 - ReceivePaymentBtn.frame.height/4, width: viewSize.width/2, height:ReceivePaymentBtn.frame.size.height/2)
        ReceivePaymentlab.text = "  收付款"
        ReceivePaymentlab.textColor =  UIColor.white
        ReceivePaymentBtn.addSubview(ReceivePaymentlab)
        let ReceivePaymentImgview = UIImageView()
        ReceivePaymentImgview.frame = CGRect(x: ReceivePaymentBtn.frame.width/2 - ReceivePaymentBtn.frame.size.height/2, y: ReceivePaymentBtn.frame.height/2 - ReceivePaymentBtn.frame.height/4 , width:ReceivePaymentBtn.frame.size.height/2, height: ReceivePaymentBtn.frame.size.height/2)
        ReceivePaymentImgview.image = UIImage(named: "ReceivePaymentiCon")
        ReceivePaymentBtn.addSubview(ReceivePaymentImgview)
        
        
        DepositBtn.frame = CGRect(x: ReceivePaymentBtn.frame.origin.x, y: ReceivePaymentBtn.frame.origin.y + ReceivePaymentBtn.frame.height + 10, width: ReceivePaymentBtn.frame.width/2 - 10 , height: ReceivePaymentBtn.frame.height)
        DepositBtn.backgroundColor = UIColor(red: 204/255.0, green: 120/255.0, blue: 0/255.0, alpha: 1)
        DepositBtn.setTitleColor(UIColor.black, for: .normal)
        DepositBtn.layer.cornerRadius = 10
        self.addSubview(DepositBtn)
        
        let Depositlab = UILabel()
        Depositlab.frame = CGRect(x: DepositBtn.frame.width/2, y: DepositBtn.frame.height/2 - DepositBtn.frame.height/4, width: viewSize.width/2, height:DepositBtn.frame.size.height/2)
        Depositlab.text = "  存提"
        Depositlab.textColor =  UIColor.white
        DepositBtn.addSubview(Depositlab)
        let DepositImgview = UIImageView()
        DepositImgview.frame = CGRect(x: DepositBtn.frame.width/2 - DepositBtn.frame.size.height/2, y: DepositBtn.frame.height/2 - DepositBtn.frame.height/4 , width:DepositBtn.frame.size.height/2, height: DepositBtn.frame.size.height/2)
        DepositImgview.image = UIImage(named: "DepositiCon")
        DepositBtn.addSubview(DepositImgview)
        
        
        ExchangeBtn.frame = CGRect(x: viewSize.width/2 + 10, y: ReceivePaymentBtn.frame.origin.y + ReceivePaymentBtn.frame.height + 10, width: ReceivePaymentBtn.frame.width/2 - 10 , height: ReceivePaymentBtn.frame.height)
        ExchangeBtn.setTitleColor(UIColor.black, for: .normal)
        ExchangeBtn.layer.cornerRadius = 10
        ExchangeBtn.backgroundColor = UIColor(red: 87/255.0, green: 94/255.0, blue: 36/255.0, alpha: 1)
        self.addSubview(ExchangeBtn)
        let Exchangelab = UILabel()
        Exchangelab.frame = CGRect(x: ExchangeBtn.frame.width/2, y: ExchangeBtn.frame.height/2 - ExchangeBtn.frame.height/4, width: viewSize.width/2, height:ExchangeBtn.frame.size.height/2)
        Exchangelab.text = "  换汇"
        Exchangelab.textColor =  UIColor.white
        ExchangeBtn.addSubview(Exchangelab)
        let ExchangeImgview = UIImageView()
        ExchangeImgview.frame = CGRect(x: ExchangeBtn.frame.width/2 - ExchangeBtn.frame.size.height/2, y: ExchangeBtn.frame.height/2 - ExchangeBtn.frame.height/4 , width:ExchangeBtn.frame.size.height/2, height: ExchangeBtn.frame.size.height/2)
        ExchangeImgview.image = UIImage(named: "ExchangeIcon")
        ExchangeBtn.addSubview(ExchangeImgview)

        
//        let Exchangelab = UILabel()
//        Exchangelab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
//        Exchangelab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
//        Exchangelab.text = "换汇"
//        Exchangelab.textAlignment = .center
//        Exchangelab.textColor = UIColor.white
//        ExchangeBtn.addSubview(Exchangelab)
        
        
        
        
//        let Depositlab = UILabel()
//        Depositlab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
//        Depositlab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
//        Depositlab.text = "存提"
//        Depositlab.textAlignment = .center
//        Depositlab.textColor = UIColor.white
//        DepositBtn.addSubview(Depositlab)
//        
//        HistoryBtn.frame = CGRect(x: viewSize.width/1.9, y: DepositBtn.frame.origin.y, width: DepositBtn.frame.width, height: DepositBtn.frame.height)
//        HistoryBtn.backgroundColor = UIColor.groupTableViewBackground
//        HistoryBtn.setImage(UIImage(named: "歷史交易.png"), for: .normal)
//        HistoryBtn.setTitleColor(UIColor.black, for: .normal)
//        HistoryBtn.layer.cornerRadius = 5
//        self.addSubview(HistoryBtn)
//        
//        let Historylab = UILabel()
//        Historylab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
//        Historylab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
//        Historylab.text = "历史交易"
//        Historylab.textAlignment = .center
//        Historylab.textColor = UIColor.white
//        
//        HistoryBtn.addSubview(Historylab)
//        
//        

//        
//        

//        
//        let ReceivePaymentlab = UILabel()
//        ReceivePaymentlab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
//        ReceivePaymentlab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
//        ReceivePaymentlab.text = "收付款"
//        ReceivePaymentlab.textAlignment = .center
//        ReceivePaymentlab.textColor = UIColor.white
//        ReceivePaymentBtn.addSubview(ReceivePaymentlab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
