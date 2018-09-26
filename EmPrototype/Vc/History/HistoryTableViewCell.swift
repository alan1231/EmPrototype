//
//  HistoryTableViewCell.swift
//  EmPrototype
//
//  Created by alan on 2018/9/6.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    var imgView: UIImageView!
    var nameLab : UILabel!
    var time : UILabel!
    var amount : UILabel!
    
    var examount : UILabel!
    var exchange : UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    func setUpUI() {
        
        imgView = UIImageView(frame: CGRect(x: viewSize.width/14, y:((viewSize.height/10)/2) - ((contentView.frame.width/6)/2), width: contentView.frame.width/6, height: contentView.frame.width/6))
        imgView.image = UIImage(named: "Contact.png")
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = imgView.frame.size.width/2
        contentView.addSubview(imgView)
        
        nameLab = UILabel.init(frame: CGRect(x: contentView.frame.size.width/3.5, y: imgView.frame.origin.y , width: viewSize.width/3, height:contentView.frame.width/12))
        nameLab.font = UIFont.systemFont(ofSize: 15)
        nameLab.textColor = UIColor.gray
        contentView.addSubview(nameLab)
        
        time = UILabel.init(frame:CGRect(x: nameLab.frame.origin.x, y: nameLab.frame.origin.y + nameLab.frame.height, width: nameLab.frame.width, height: nameLab.frame.height))
        time.font = UIFont.systemFont(ofSize: 13)
        time.textColor = UIColor.gray
        contentView.addSubview(time)
        
        amount = UILabel.init(frame:CGRect(x: viewSize.width/1.75, y: imgView.frame.origin.y, width: nameLab.frame.width*0.9, height: imgView.frame.height))
        amount.textColor = UIColor.gray
        amount.font = UIFont.systemFont(ofSize: 16)
        amount.textAlignment = .right
        contentView.addSubview(amount)
        
        
        examount = UILabel.init(frame:CGRect(x: amount.frame.origin.x, y: nameLab.frame.origin.y, width: amount.frame.width, height: nameLab.frame.height))
        examount.font = UIFont.systemFont(ofSize: 15)
        examount.textColor = UIColor.gray
        examount.textAlignment = .right
        contentView.addSubview(examount)
        
        exchange = UILabel.init(frame:CGRect(x: amount.frame.origin.x, y: time.frame.origin.y, width: amount.frame.width, height: nameLab.frame.height))
        exchange.font = UIFont.systemFont(ofSize: 13)
        exchange.textColor = UIColor.gray
        exchange.textAlignment = .right
        contentView.addSubview(exchange)
    }
}
