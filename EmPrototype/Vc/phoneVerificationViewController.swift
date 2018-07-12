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
    let loadviewBG = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topview = UILabel()
        topview.backgroundColor = mobiColor
        topview.frame = CGRect(x: 0 , y: 0, width: view.frame.size.width, height: view.frame.size.height/6)
        view.addSubview(topview)
        
        let btn = UIButton ()
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.frame = CGRect(x: width/20, y: height/25, width: width/8
            , height: height/25)
        btn.addTarget(self, action: #selector(self.back(sender:)), for: .touchUpInside)
        view.addSubview(btn)
        
        
        view.backgroundColor = UIColor.white
//        self.title = "输入验证码"
//        let newBackButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.done, target: self, action:#selector(self.back(sender:)))
//        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        
        
        messageTextField.frame = CGRect(x: 27, y: 160, width: view.frame.size.width/1.2, height: 40)
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
        numberLab.text = phoneNumberViewController.myphoneNumber
//        numberLab.text = "+886978768913"
        numberLab.textAlignment = .center
        numberLab.font = UIFont.systemFont(ofSize: 15)
        numberLab.frame = messageTextField.frame
        numberLab.frame.origin.y = 200
        numberLab.frame.size.height = numberLab.frame.size.height * 0.7
        numberLab.textColor = UIColor(red: 59/255, green: 196/255, blue: 89/255, alpha: 1)
        view.addSubview(numberLab)
        
        
        
        let messageCodeLab = UILabel()
        messageCodeLab.textColor = cgGray
        messageCodeLab.text = "请输入简讯内的认证码。"
        messageCodeLab.textAlignment = .center
        messageCodeLab.font = UIFont.systemFont(ofSize: 15)
        messageCodeLab.frame = numberLab.frame
        messageCodeLab.frame.origin.y = 220
        view.addSubview(messageCodeLab)
        
        let h1 = UILabel()
        h1.textColor = cgGray
        h1.text = "若您未收到简讯，请尝试下列方法："
        h1.textAlignment = .center
        h1.font = UIFont.systemFont(ofSize: 15)
        h1.frame = numberLab.frame
        h1.frame.origin.y = 240
        view.addSubview(h1)
        
        let restMessageCodeBtn = UIButton()
        restMessageCodeBtn.setTitle("重新传送认证码", for: .normal)
        restMessageCodeBtn.setTitleColor(cgBlackGray, for: .normal)
        restMessageCodeBtn.frame = numberLab.frame
        restMessageCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        restMessageCodeBtn.frame.origin.y = 265
        restMessageCodeBtn.frame.size.height += -10
        restMessageCodeBtn.frame.size.width = getSizeFromString(string: "重新传送认证码", withFont:UIFont.systemFont(ofSize: 15)).width
        restMessageCodeBtn.frame.origin.x = view.frame.size.width/2 - restMessageCodeBtn.frame.size.width/2
        restMessageCodeBtn.layer.addBorder(edge: .bottom, color: UIColor(red: 149/255, green: 149/255, blue: 152/255, alpha: 1), thickness: 1)
        view.addSubview(restMessageCodeBtn)
        
        
        nextBtn.frame = messageTextField.frame
        nextBtn.frame.origin.y = 300
        nextBtn.backgroundColor = mobiColor
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.layer.cornerRadius = 20
        nextBtn.addTarget(self, action: #selector(self.nextView), for: .touchUpInside)
        nextBtn.setTitle("确定", for: .normal)
        view.addSubview(nextBtn)
        
    }
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = true

    }
    
    @objc func nextView(){
        messageTextField.resignFirstResponder()

        self.setupView()

        APIManager.getApi.sendMessage(phoneNumberViewController.myphoneNumber, self.messageTextField.text!, completion: {result,token,err    in
    
            if result == "ok"{
                self.loadviewBG.removeFromSuperview()

                
                phoneNumberViewController.token = token!
                print(phoneNumberViewController.token)
                let alert = UIAlertController(title: "完成簡訊認證", message: nil, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                    let vc = pinCodeView()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }))
                self.present(alert, animated: false)

            }else{
                self.loadviewBG.removeFromSuperview()
                self.messageTextField.becomeFirstResponder()
                self.messageTextField.shake()
                self.messageTextField.text = ""
            }
            
        })

    }
    
    @objc func nextView2(str: String){
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else{
            return true
        }
        
        let textLength = text.count + string.count - range.length
        
        return textLength<=4
    }
    
    func getSizeFromString(string:String, withFont font:UIFont)->CGSize{
        
        let textSize = NSString(string: string ).size(
            
            withAttributes: [ NSAttributedStringKey.font:font ])
        
        return textSize
        
    }
    
    fileprivate func setupView() {
        
        loadviewBG.frame = view.frame
        loadviewBG.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        view.addSubview(loadviewBG)
        
        
        let lview = UIView()
        lview.backgroundColor = UIColor.white
        lview.frame = CGRect(x: view.frame.midX-40, y: view.frame.midY-40, width: 80, height: 80)
        lview.layer.cornerRadius = lview.frame.size.width/2
        loadviewBG.addSubview(lview)
        
        let loadingView = LoadingView(frame: CGRect(x: lview.frame.width/2 - 30, y: lview.frame.height/2 - 30, width: 60, height: 60))
        
        loadingView.startLoading()
        lview.addSubview(loadingView)
        
    }


}
