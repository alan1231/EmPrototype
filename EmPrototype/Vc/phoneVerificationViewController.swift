//
//  phoneVerificationViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/6/28.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class phoneVerificationViewController: UIViewController,UITextFieldDelegate {
    let messageTextField = UITextField()
    let nextBtn = UIButton()
    let restMessageCodeBtn = UIButton()
    
    var second = 60
    var timer = Timer()
    var isTimerRun = true
    var str = String()
    var phoneStr = String()
    var bordview = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topview = UILabel()
        topview.backgroundColor = mobiColor
        topview.frame = CGRect(x: 0 , y: 0, width: view.frame.size.width, height: view.frame.size.height/6)
        view.addSubview(topview)
        
        let btn = UIButton ()
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.frame = CGRect(x: width/20, y: ((view.frame.size.height/6)/2)-(height/25)/2, width: width/8
            , height: height/25)
        btn.addTarget(self, action: #selector(self.back(sender:)), for: .touchUpInside)
        view.addSubview(btn)
        
        
        view.backgroundColor = UIColor.white
//        self.title = "输入验证码"
//        let newBackButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.done, target: self, action:#selector(self.back(sender:)))
//        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        
        messageTextField.frame = CGRect(x: view.frame.width/2 - (view.frame.width/1.2)/2, y: view.frame.size.height/3.55, width: view.frame.size.width/1.2, height: view.frame.size.height/15)
        
        messageTextField.becomeFirstResponder()
        messageTextField.keyboardType = UIKeyboardType.numberPad
        messageTextField.backgroundColor = UIColor.white
        messageTextField.attributedPlaceholder = "输入验证码".attributedString(aligment: .center)
        messageTextField.textAlignment = .center
        messageTextField.layer.addBorder(edge: .bottom, color: UIColor.groupTableViewBackground, thickness: 1)
        messageTextField.font = UIFont.systemFont(ofSize: 26)
        messageTextField.delegate = self
        
        //textfield text 字距
        messageTextField.defaultTextAttributes
            .updateValue(12, forKey: NSAttributedStringKey.kern.rawValue)
        
        view.addSubview(messageTextField)
        
        let numberLab = UILabel()
        numberLab.text = phoneStr
        numberLab.textAlignment = .center
        numberLab.font = UIFont.systemFont(ofSize: 15)
        numberLab.frame = messageTextField.frame
        numberLab.frame.origin.y = view.frame.size.height/2.84
        numberLab.frame.size.height = numberLab.frame.size.height * 0.7
        numberLab.textColor = UIColor(red: 59/255, green: 196/255, blue: 89/255, alpha: 1)
        view.addSubview(numberLab)
        

        
        let messageCodeLab = UILabel()
        messageCodeLab.textColor = cgGray
        messageCodeLab.text = "请输入简讯内的验证码。"
        messageCodeLab.textAlignment = .center
        messageCodeLab.font = UIFont.systemFont(ofSize: 15)
        messageCodeLab.frame = numberLab.frame
        messageCodeLab.frame.origin.y = view.frame.size.height/2.58
        view.addSubview(messageCodeLab)
        
        let h1 = UILabel()
        h1.textColor = cgGray
        h1.text = "若您未收到简讯，请尝试下列方法："
        h1.textAlignment = .center
        h1.font = UIFont.systemFont(ofSize: 15)
        h1.frame = numberLab.frame
        h1.frame.origin.y = view.frame.size.height/2.37
        view.addSubview(h1)
        

        restMessageCodeBtn.setTitleColor(cgBlackGray, for: .normal)
        restMessageCodeBtn.frame = numberLab.frame
        restMessageCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        restMessageCodeBtn.frame.origin.y = view.frame.size.height/2.14
        restMessageCodeBtn.frame.size.height += -10
        restMessageCodeBtn.setTitle("重新传送验证码", for: .normal)
        restMessageCodeBtn.frame.size.width = getSizeFromString(string: "重新传送验证码", withFont:UIFont.systemFont(ofSize: 15)).width
        restMessageCodeBtn.frame.origin.x = view.frame.size.width/2 - restMessageCodeBtn.frame.size.width/2
//        restMessageCodeBtn.layer.addBorder(edge: .bottom, color: UIColor(red: 149/255, green: 149/255, blue: 152/255, alpha: 1), thickness: 1)
        restMessageCodeBtn.addTarget(self, action: #selector(self.restMessage), for: .touchUpInside)
//        restMessageCodeBtn.setAttributedTitle(NSAttributedString(string: "沒有收到驗證碼嗎？請等待60s",
//                                                      attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]), for: .normal)
        view.addSubview(restMessageCodeBtn)
        
        bordview.frame = restMessageCodeBtn.frame
        bordview.frame.origin.y = restMessageCodeBtn.frame.origin.y + restMessageCodeBtn.frame.size.height
        bordview.frame.size.height = 1
        bordview.backgroundColor = UIColor(red: 149/255, green: 149/255, blue: 152/255, alpha: 1)
        view.addSubview(bordview)
        
        
        
        
        
        nextBtn.frame = messageTextField.frame
        nextBtn.frame.origin.y = view.frame.size.height/1.889
        nextBtn.frame.size.height = 40
        nextBtn.backgroundColor = mobiColor
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.layer.cornerRadius = 20
        nextBtn.addTarget(self, action: #selector(self.nextView), for: .touchUpInside)
        nextBtn.setTitle("确定", for: .normal)
        view.addSubview(nextBtn)
//        restMessageCodeBtn.isHidden = true
//        bordview.isHidden = true
//        runTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func restMessage (){
        if isTimerRun == true{
            second = 60
            runTimer()
            isTimerRun = false
            
            
            APIManager.getApi.sendPhoneNumber(user.get("PhoneNumber"), completion: { result,err   in
                if (result)!{
                    print("ok")
                }else{
                    print("err")
                }
            })
        }
 
    }
    
    @objc func updateTimer(){
        
        if second == 0 {
            isTimerRun = true
            restMessageCodeBtn.isHidden = false
            bordview.isHidden = false
            timer.invalidate()
             str = "重新传送验证码"
            restMessageCodeBtn.setTitle(str, for: .normal)
            restMessageCodeBtn.frame.size.width = getSizeFromString(string: str , withFont:UIFont.systemFont(ofSize: 15)).width
            restMessageCodeBtn.frame.origin.x = view.frame.size.width/2 - restMessageCodeBtn.frame.size.width/2
            bordview.frame.origin.x = restMessageCodeBtn.frame.origin.x
            bordview.frame.size.width = restMessageCodeBtn.frame.size.width

            restMessageCodeBtn.invalidateIntrinsicContentSize()

        }else{
            second -= 1
             str = "没有收到验证码吗？请等待\(second)秒"
            restMessageCodeBtn.setTitle(str, for: .normal)
            restMessageCodeBtn.frame.size.width = getSizeFromString(string: str , withFont:UIFont.systemFont(ofSize: 15)).width
            restMessageCodeBtn.frame.origin.x = view.frame.size.width/2 - restMessageCodeBtn.frame.width/2
            bordview.frame.origin.x = restMessageCodeBtn.frame.origin.x
            bordview.frame.size.width = restMessageCodeBtn.frame.size.width
            bordview.isHidden = true

        }

        
    }
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    @objc func nextView(){
        messageTextField.resignFirstResponder()

        setupView(view)
        APIManager.getApi.sendMessage(user.get("PhoneNumber"), self.messageTextField.text!,user.get("DeviceToken"), completion: {token,status,err    in
    
            if status == "ok" {
                stoploadingView()
                user.save("Token", token!)
                let vc = pinViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.navigationBar.isHidden = false
                
                self.timer.invalidate()
                
//                APIManager.getApi.sendDevicetoken(user.get("DeviceToken"), completion:{
//                    result in
//
//                    if result! {
//                        print("device token push ok")
//                    }
//
//                })
                
//                let alert = UIAlertController(title: "完成簡訊認證", message: nil, preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
//                
//
//                }))
//                self.present(alert, animated: true)

            }else{
                stoploadingView()
                
                self.messageTextField.becomeFirstResponder()
                self.messageTextField.shake()
//                self.messageTextField.attributedPlaceholder = "输入验证码".attributedString(aligment: .center)

                self.messageTextField.attributedPlaceholder = NSAttributedString(string:
                    "验证码错误", attributes:
                    [NSAttributedStringKey.foregroundColor:UIColor.red])
                self.messageTextField.text = ""
            }
            
        })

    }
    
 
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else{
            return true
        }
        
        let textLength = text.count + string.count - range.length
        
        return textLength<=4
    }
    
   
    



}
