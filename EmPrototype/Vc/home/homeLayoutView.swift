//
//  homeLayoutView.swift
//  EmPrototype
//
//  Created by alan on 2018/7/16.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class homeLayoutView: UIView {

    let DepositBtn = UIButton()
    let HistoryBtn = UIButton()
    let ExchangeBtn = UIButton()
    let ReceivePaymentBtn = UIButton()
    let BalanceBtn = UIButton()
    init(frame: CGRect,VC:homeViewController) {
        super.init(frame:frame)
        
        
        BalanceBtn.frame = CGRect(x:viewSize.width/20, y: viewSize.height/3.1, width: viewSize.width - (viewSize.width/20*2), height: viewSize.height/6)
        BalanceBtn.layer.addBorder(edge: .top, color: UIColor.groupTableViewBackground, thickness: 2)
        BalanceBtn.layer.addBorder(edge: .bottom, color: UIColor.groupTableViewBackground, thickness: 2)
        BalanceBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 38)
        BalanceBtn.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(BalanceBtn)

        let uilab = UILabel()
        uilab.frame = CGRect(x: BalanceBtn.frame.origin.x, y: BalanceBtn.frame.origin.y + 5, width: 100, height: 30)
        uilab.text = "人民币余额"
        self.addSubview(uilab)
        
        
        DepositBtn.frame = CGRect(x: viewSize.width/20, y: viewSize.height/2 + (viewSize.width/17), width: viewSize.width/1.9 - (viewSize.width/20*2), height: viewSize.height/5)
        DepositBtn.backgroundColor = UIColor.groupTableViewBackground
        DepositBtn.setTitle("存提", for: .normal)
        DepositBtn.setImage(UIImage(named: "存提.png"), for: .normal)
        DepositBtn.layer.cornerRadius = 5
        DepositBtn.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(DepositBtn)
        
        let Depositlab = UILabel()
        Depositlab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        Depositlab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
        Depositlab.text = "存提"
        Depositlab.textAlignment = .center
        Depositlab.textColor = UIColor.white
        DepositBtn.addSubview(Depositlab)
        
        HistoryBtn.frame = CGRect(x: viewSize.width/1.9, y: DepositBtn.frame.origin.y, width: DepositBtn.frame.width, height: DepositBtn.frame.height)
        HistoryBtn.backgroundColor = UIColor.groupTableViewBackground
        HistoryBtn.setImage(UIImage(named: "歷史交易.png"), for: .normal)
        HistoryBtn.setTitleColor(UIColor.black, for: .normal)
        HistoryBtn.layer.cornerRadius = 5
        self.addSubview(HistoryBtn)

        let Historylab = UILabel()
        Historylab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        Historylab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
        Historylab.text = "历史交易"
        Historylab.textAlignment = .center
        Historylab.textColor = UIColor.white
        
        HistoryBtn.addSubview(Historylab)
        

        ExchangeBtn.frame = CGRect(x: viewSize.width/20, y: DepositBtn.frame.origin.y + DepositBtn.frame.height + viewSize.width/20, width: DepositBtn.frame.width, height: DepositBtn.frame.height)
        ExchangeBtn.backgroundColor = UIColor.groupTableViewBackground
        ExchangeBtn.setImage(UIImage(named: "換匯.png"), for: .normal)
        ExchangeBtn.setTitleColor(UIColor.black, for: .normal)
        ExchangeBtn.layer.cornerRadius = 5
        self.addSubview(ExchangeBtn)
        let Exchangelab = UILabel()
        Exchangelab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        Exchangelab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
        Exchangelab.text = "换汇"
        Exchangelab.textAlignment = .center
        Exchangelab.textColor = UIColor.white
        ExchangeBtn.addSubview(Exchangelab)
        
        
        ReceivePaymentBtn.frame = CGRect(x: HistoryBtn.frame.origin.x, y: ExchangeBtn.frame.origin.y, width: DepositBtn.frame.width, height: DepositBtn.frame.height)
        ReceivePaymentBtn.backgroundColor = UIColor.groupTableViewBackground
        ReceivePaymentBtn.setTitle("收付款", for: .normal)
        ReceivePaymentBtn.setImage(UIImage(named: "Group.png"), for: .normal)
        ReceivePaymentBtn.layer.cornerRadius = 5
        ReceivePaymentBtn.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(ReceivePaymentBtn)
        
        let ReceivePaymentlab = UILabel()
        ReceivePaymentlab.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        ReceivePaymentlab.center = CGPoint(x: DepositBtn.frame.size.width * 0.5, y: DepositBtn.frame.size.height * 0.75)
        ReceivePaymentlab.text = "收付款"
        ReceivePaymentlab.textAlignment = .center
        ReceivePaymentlab.textColor = UIColor.white
        ReceivePaymentBtn.addSubview(ReceivePaymentlab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
