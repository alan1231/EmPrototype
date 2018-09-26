//
//  BalanceTableViewCell.swift
//  EmPrototype
//
//  Created by alan on 2018/8/23.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

    class BalanceTableViewCell: MGSwipeTableCell {
        var titlelab : UILabel!
        var bgview : UIView!
        var showImage   : UIImageView!
        var rise : UILabel!
        var total : UILabel!
        var name  : UILabel!
        var balance    : UILabel!
        var lineView : UIView!
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)

        }

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.setUpUI()
        }
        
        func setUpUI() {
            
   
            lineView = UIView(frame: CGRect(x: contentView.frame.width/15, y: 3, width: viewSize.width - (contentView.frame.width/15)*2 , height: 1))
            contentView.addSubview(lineView)
            drawDashLine(lineView: lineView, lineLength: 3, lineSpacing: 3, lineColor: UIColor.gray)
            lineView.isHidden = true

            titlelab = UILabel(frame: CGRect(x: contentView.frame.width/12, y: 5, width: viewSize.width, height: viewSize.height/30))
            titlelab.font = UIFont.systemFont(ofSize: 12)
            self.contentView.addSubview(titlelab)
            
            bgview = UIView(frame: CGRect(x: contentView.frame.width/15, y: viewSize.height/25, width: viewSize.width - (contentView.frame.width/15)*2, height: viewSize.height/8.3))
            bgview.backgroundColor = UIColor.white
            bgview.layer.shadowOffset = CGSize(width: 5, height: 5)
            bgview.layer.cornerRadius = 8
            bgview.layer.shadowRadius = 5
            bgview.layer.shadowOpacity = 0.5;

            self.contentView.addSubview(bgview)
           
            
            showImage = UIImageView(frame: CGRect(x: bgview.frame.size.width/40, y:bgview.frame.size.height/2 - ((contentView.frame.width/6)/2), width: contentView.frame.width/6, height: contentView.frame.width/6))
            showImage?.image = UIImage(named: "usdcoin.png")
            bgview.addSubview(showImage)
            
            name = UILabel.init(frame: CGRect(x: bgview.frame.size.width/5, y: showImage.frame.origin.y, width: viewSize.width/7, height: viewSize.height/25))
            name.font = UIFont.systemFont(ofSize: 24)
            name.textColor = UIColor.black
            bgview.addSubview(name)
            
            rise = UILabel(frame: CGRect(x: name.frame.origin.x, y: name.frame.origin.y+name.frame.size.height, width: viewSize.width/4, height: viewSize.height/50))
            rise.text = "0.026 (0.38%) ↑"
            rise.font = UIFont.systemFont(ofSize: 10)
            bgview.addSubview(rise)
            
            
            balance = UILabel.init(frame: CGRect(x: name.frame.origin.x*0.95 + name.frame.size.width, y: showImage.frame.origin.y, width: viewSize.width/2, height: viewSize.height/25))
            balance.font = UIFont.systemFont(ofSize: 24)
            balance.textAlignment = NSTextAlignment.right
            balance.textColor = UIColor.red
            bgview.addSubview(balance)
            
            total = UILabel(frame: CGRect(x: balance.frame.origin.x, y:rise.frame.origin.y, width: balance.frame.size.width, height: rise.frame.height))
            total.text = "≈￥465,091.802"
            total.textAlignment = NSTextAlignment.right
            total.font = UIFont.systemFont(ofSize: 10)
            bgview.addSubview(total)
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
        
        func drawDashLine(lineView : UIView,lineLength : Int ,lineSpacing : Int,lineColor : UIColor){
            let shapeLayer = CAShapeLayer()
            shapeLayer.bounds = lineView.bounds
            //        只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
            shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
            //        shapeLayer.fillColor = UIColor.blue.cgColor
            shapeLayer.strokeColor = lineColor.cgColor
            
            shapeLayer.lineWidth = lineView.frame.size.height
            shapeLayer.lineJoin = CAShapeLayerLineJoin.round
            
            shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: lineView.frame.size.width, y: 0))
            
            shapeLayer.path = path
            lineView.layer.addSublayer(shapeLayer)
        }
        
    }

