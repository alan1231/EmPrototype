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
        DepositBtn.layer.cornerRadius = 5
        DepositBtn.setTitleColor(UIColor.black, for: .normal)

        self.addSubview(DepositBtn)
        
        HistoryBtn.frame = CGRect(x: viewSize.width/1.9, y: DepositBtn.frame.origin.y, width: DepositBtn.frame.width, height: DepositBtn.frame.height)
        HistoryBtn.backgroundColor = UIColor.groupTableViewBackground
        HistoryBtn.setTitle("历史交易", for: .normal)
        HistoryBtn.setTitleColor(UIColor.black, for: .normal)
        HistoryBtn.layer.cornerRadius = 5
        self.addSubview(HistoryBtn)
        
        ExchangeBtn.frame = CGRect(x: viewSize.width/20, y: DepositBtn.frame.origin.y + DepositBtn.frame.height + viewSize.width/20, width: DepositBtn.frame.width, height: DepositBtn.frame.height)
        ExchangeBtn.backgroundColor = UIColor.groupTableViewBackground
        ExchangeBtn.setTitle("换汇", for: .normal)
        ExchangeBtn.setTitleColor(UIColor.black, for: .normal)
        ExchangeBtn.layer.cornerRadius = 5

        self.addSubview(ExchangeBtn)

        ReceivePaymentBtn.frame = CGRect(x: HistoryBtn.frame.origin.x, y: ExchangeBtn.frame.origin.y, width: DepositBtn.frame.width, height: DepositBtn.frame.height)
        ReceivePaymentBtn.backgroundColor = UIColor.groupTableViewBackground
        ReceivePaymentBtn.setTitle("收付款", for: .normal)
        ReceivePaymentBtn.layer.cornerRadius = 5
        ReceivePaymentBtn.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(ReceivePaymentBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
