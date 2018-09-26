//
//  BalanceSettingTableViewCell.swift
//  EmPrototype
//
//  Created by alan on 2018/9/18.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class BalanceSettingTableViewCell: UITableViewCell {
    var imgView: UIImageView!
    var nameLab : UILabel! 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    func setUpUI() {
        imgView = UIImageView(frame: CGRect(x: 0, y:((viewSize.height/8)/2) - ((contentView.frame.width/6)/2), width: contentView.frame.width/6, height: contentView.frame.width/6))
        imgView?.image = UIImage(named: "usdcoin.png")
        contentView.addSubview(imgView)
        nameLab = UILabel.init(frame: CGRect(x: contentView.frame.size.width/5, y: imgView.frame.origin.y, width: viewSize.width/2, height: imgView.frame.height))
        nameLab.font = UIFont.systemFont(ofSize: 24)
        nameLab.textColor = UIColor.black
        contentView.addSubview(nameLab)
        
    }

}
