//
//  BalanceTableViewCell.swift
//  EmPrototype
//
//  Created by alan on 2018/8/23.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

    class BalanceTableViewCell: MGSwipeTableCell {
        
        var showImage   : UIImageView?
        var name  : UILabel?
        var balance    : UILabel?
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)

        }

        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.setUpUI()
        }
        
        func setUpUI() {
//            firstTitle = UILabel.init(frame: (CGRect(x: 0, y: 0, width: 50, height: 50))
            
//            showImage = UIImageView.init(frame: CGRectMake(5, 5, SCREENWIDTH-10, 170))
//            showImage!.layer.masksToBounds = true
//            self.addSubview(showImage!)
//
//            subTitle = UILabel.init(frame: CGRectMake(10, 150, (showImage?.frame.size.width)!-20, 12))
//            subTitle?.font = UIFont.systemFontOfSize(15)
//            subTitle?.textAlignment = NSTextAlignment.Center
//            subTitle?.textColor = UIColor.redColor()
//            self.addSubview(subTitle!)
//
            name = UILabel.init(frame: CGRect(x: contentView.frame.width/4, y: contentView.frame.origin.y, width: viewSize.width/4, height: viewSize.height/10))
            name?.font = UIFont.systemFont(ofSize: 24)
            name?.textAlignment = NSTextAlignment.center
            name?.textColor = UIColor.blue
//            name?.backgroundColor = UIColor.orange
            self.contentView.addSubview(name!)
            
            balance = UILabel.init(frame: CGRect(x: name!.frame.origin.x + name!.frame.size.width, y: contentView.frame.origin.y, width: viewSize.width/2, height: viewSize.height/10))
            balance?.font = UIFont.systemFont(ofSize: 24)
            balance?.textAlignment = NSTextAlignment.right
//            balance?.backgroundColor = UIColor.yellow
            balance?.textColor = UIColor.black
            self.contentView.addSubview(balance!)
            
        }
        
//        func setValueForCell(dic: NSDictionary) {
//            subTitle!.text = "45道菜谱"
//            firstTitle!.text = "世界各地大排档的招牌美食"
//            showImage!.image = UIImage(imageLiteral: "img.jpg")
//        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
    }

