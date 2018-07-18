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
    let nextBtn = UIButton()
    var pinBool:Bool = true

    init(frame: CGRect,VC:pinViewController) {
        super.init(frame:frame)
        
        pinLab.frame = CGRect(x: 0, y: Int(viewSize.height/2.8), width: Int(viewSize.width), height: Int(viewSize.width/20))
        self.addSubview(pinLab)
        
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
            
        
            
            nextBtn.frame = CGRect(x: viewSize.width/2 - viewSize.width/10 , y: pinLab.frame.origin.y + pinLab.frame.size.height + viewSize.height/5.5, width: viewSize.width/5, height: 40)
            nextBtn.addTarget(self, action: #selector(self.pinchange), for: .touchUpInside)
            nextBtn.setTitle("PIN选项", for: .normal)
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
            inputlab.text = "解锁"
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
        
        switch user.get("PinNumber"){
        case "3":
            addCode(Int(user.get("PinNumber"))!, nb: 2.7)
        case "5":
            addCode(Int(user.get("PinNumber"))!, nb: 3.6)
        default:break
        }
       

    
        
        //        let forgetBtn = UIButton()
        //        forgetBtn.frame = CGRect(x: (viewSize.width/2)-((viewSize.width/4)/2), y: 350, width: viewSize.width/4, height: viewSize.height/30)
        //        forgetBtn.setTitle("忘記密碼？", for: .normal)
        //        forgetBtn.setTitleColor(systemBuleColor, for: .normal)
        //        self.addSubview(forgetBtn)
        
    }
    @objc func pinchange(){
        
        if pinBool {
            pinBool = false
            pinLab.removeFromSuperview()
            pinLab = UILabel()
            pinLab.frame = CGRect(x: 0, y: Int(viewSize.height/2.8), width: Int(viewSize.width), height: Int(viewSize.width/20))
            self.addSubview(pinLab)
            addCode(3, nb: 2.7)
            nextBtn.setTitle("PIN选项4", for: .normal)
            print("1")

        }else{
            pinBool = true
            pinLab.removeFromSuperview()
            pinLab = UILabel()
            pinLab.frame = CGRect(x: 0, y: Int(viewSize.height/2.8), width: Int(viewSize.width), height: Int(viewSize.width/20))
            self.addSubview(pinLab)
            addCode(5, nb: 3.6)
            nextBtn.setTitle("PIN选项6", for: .normal)

            print("2")
        }
        
        let defaults3 = UserDefaults.standard
        defaults3.set("5", forKey: "PinNumber")
        defaults3.synchronize()

    }
    
    @objc func addCode (_ int:Int ,nb:CGFloat){
        for i in 0...int{
            let lab = UILabel()
            lab.frame = CGRect(x: (Int(viewSize.width/12)*i)+Int(viewSize.width/nb), y: 0, width: Int(viewSize.width/20), height: Int(viewSize.width/20))
            lab.backgroundColor = systemBuleColor
            lab.layer.cornerRadius=lab.bounds.width/2
            lab.layer.masksToBounds=true
            lab.isHidden = true
            pinLab.addSubview(lab)
            labArry.append(lab)
        }
        
        
        for i in 0...int{
            let lab = UILabel()
            lab.frame = CGRect(x: (Int(viewSize.width/12)*i)+Int(viewSize.width/nb)
                , y: 0 + Int((viewSize.width/20)/2)-1, width: Int(viewSize.width/20), height: 3)
            lab.backgroundColor = systemBuleColor
            pinLab.addSubview(lab)
            labArry2.append(lab)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

