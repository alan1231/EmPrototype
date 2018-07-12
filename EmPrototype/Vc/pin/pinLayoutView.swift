//
//  pinLayoutView.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class pinLayoutView: UIView {
    var labArry = [UILabel]()
    var labArry2 = [UILabel]()
    var pinLab = UILabel()
    init(frame: CGRect,VC:pinViewController) {
        super.init(frame:frame)
        
        switch phoneNumberViewController.PinStatus {
            
        case "1":
            
            let inputlab = UILabel()
            inputlab.text = "设置新的PinNCode"
            inputlab.textColor = UIColor.black
            inputlab.frame = CGRect(x: 0, y: 120, width: viewSize.width, height: viewSize.height/26)
            inputlab.font = UIFont.systemFont(ofSize:25)
            inputlab.textAlignment = .center
            self.addSubview(inputlab)
            
            let h1 = UILabel()
            h1.text = "您的PinCode将用于登录和确认交易"
            h1.textColor = cgBlackGray
            h1.frame = CGRect(x: 0, y: 160, width: viewSize.width, height: viewSize.height/26)
            h1.font = UIFont.systemFont(ofSize:15)
            h1.textAlignment = .center
            self.addSubview(h1)
        case "2":
            let inputlab = UILabel()
            inputlab.text = "确认新的PinNCode"
            inputlab.textColor = UIColor.black
            inputlab.frame = CGRect(x: 0, y: 120, width: viewSize.width, height: viewSize.height/26)
            inputlab.font = UIFont.systemFont(ofSize:25)
            inputlab.textAlignment = .center
            self.addSubview(inputlab)
        case "3":
            print("驗證")
        default: break
        }
        
        pinLab.frame = CGRect(x: 0, y: 280, width: Int(viewSize.width), height: Int(viewSize.width/20))
        self.addSubview(pinLab)
        
        for i in 0...5{
            let lab = UILabel()
            lab.frame = CGRect(x: (Int(viewSize.width/6.6)*i)+Int(viewSize.width/10.4), y: 0, width: Int(viewSize.width/20), height: Int(viewSize.width/20))
            lab.backgroundColor = systemBuleColor
            lab.layer.cornerRadius=lab.bounds.width/2
            lab.layer.masksToBounds=true
            lab.isHidden = true
            pinLab.addSubview(lab)
            labArry.append(lab)
        }
        
        
        for i in 0...5{
            let lab = UILabel()
            lab.frame = CGRect(x: (Int(viewSize.width/6.6)*i)+Int(viewSize.width/10.4)
                , y: 0 + Int((viewSize.width/20)/2)-1, width: Int(viewSize.width/20), height: 3)
            lab.backgroundColor = systemBuleColor
            //            lab.layer.cornerRadius=lab.bounds.width/2
            //            lab.layer.masksToBounds=true
            pinLab.addSubview(lab)
            labArry2.append(lab)
        }
        
        
        //        let forgetBtn = UIButton()
        //        forgetBtn.frame = CGRect(x: (viewSize.width/2)-((viewSize.width/4)/2), y: 350, width: viewSize.width/4, height: viewSize.height/30)
        //        forgetBtn.setTitle("忘記密碼？", for: .normal)
        //        forgetBtn.setTitleColor(systemBuleColor, for: .normal)
        //        self.addSubview(forgetBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

