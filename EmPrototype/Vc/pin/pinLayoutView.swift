//
//  pinLayoutView.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class pinLayoutView: UIView {
    
    let nextBtn = UIButton()
    var pinBool:Bool = true
    
    init(frame: CGRect,VC:pinViewController) {
        super.init(frame:frame)
        
        
        switch user.get("PinStatus") {
            
        case "1":
            
            let inputlab = UILabel()
            inputlab.text = "设置新的PinCode"
            inputlab.textColor = UIColor.black
            inputlab.frame = CGRect(x: 0, y: viewSize.height/4.73, width: viewSize.width, height: viewSize.height/26)
            inputlab.font = UIFont.systemFont(ofSize:25)
            inputlab.textAlignment = .center
            self.addSubview(inputlab)
            
            let h1 = UILabel()
            h1.text = "您的PinCode将用于登录和确认交易"
            h1.textColor = cgBlackGray
            h1.frame = CGRect(x: 0, y: viewSize.height/3.55, width: viewSize.width, height: viewSize.height/26)
            h1.font = UIFont.systemFont(ofSize:15)
            h1.textAlignment = .center
            self.addSubview(h1)
            
            
            
            
            //            nextBtn.addTarget(self, action: #selector(self.pinchange), for: .touchUpInside)
            nextBtn.setTitle("六位数PinCode", for: .normal)
            nextBtn.frame.size.width = viewSize.width/2.7
            nextBtn.frame.origin.x = viewSize.width/2 - nextBtn.frame.size.width/2
            nextBtn.frame.size.height = 40
            nextBtn.setTitleColor(UIColor(red: 41/255, green: 125/255, blue: 245/255, alpha: 1), for: .normal)
            self.addSubview(nextBtn)
            
            
            
        case "2":
            let inputlab = UILabel()
            inputlab.text = "确认新的PinCode"
            inputlab.textColor = UIColor.black
            inputlab.frame = CGRect(x: 0, y: viewSize.height/4.73, width: viewSize.width, height: viewSize.height/26)
            inputlab.font = UIFont.systemFont(ofSize:25)
            inputlab.textAlignment = .center
            
            
            self.addSubview(inputlab)
        case "3":
            
            let inputlab = UILabel()
            inputlab.text = localizedStr("Unlock")
            inputlab.textColor = UIColor.black
            inputlab.frame = CGRect(x: 0, y: viewSize.height/4.73, width: viewSize.width, height: viewSize.height/26)
            inputlab.font = UIFont.systemFont(ofSize:25)
            inputlab.textAlignment = .center
            self.addSubview(inputlab)
            
            let h1 = UILabel()
            h1.text = "请输入PinCode"
            h1.textColor = cgBlackGray
            h1.frame = CGRect(x: 0, y: viewSize.height/3.55, width: viewSize.width, height: viewSize.height/26)
            h1.font = UIFont.systemFont(ofSize:15)
            h1.textAlignment = .center
            self.addSubview(h1)
            
            //
            //            nextBtn.frame = CGRect(x: viewSize.width/2 - viewSize.width/10 , y: pinLab.frame.origin.y + pinLab.frame.size.height + viewSize.height/5.5, width: viewSize.width/5, height: 40)
            //            nextBtn.addTarget(self, action: #selector(self.pinchange), for: .touchUpInside)
            //            nextBtn.setTitle("PIN选项6", for: .normal)
            //            nextBtn.setTitleColor(UIColor(red: 41/255, green: 125/255, blue: 245/255, alpha: 1), for: .normal)
            //            self.addSubview(nextBtn)
            
        default: break
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

