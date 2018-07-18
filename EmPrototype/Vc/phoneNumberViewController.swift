//
//  phoneNumberViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/6/28.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import CountryPickerView
import Alamofire
import libPhoneNumber_iOS
class phoneNumberViewController: UIViewController,UITextFieldDelegate {
    
    let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 125, height: 20))
    
    let loadviewBG = UIView()
    
    var messageCode = UITextField()

    var  phoneNumberField = UITextField()
    
    let nextBtn = UIButton()
    
    var phoneNumber = NBPhoneNumber()
    var phoneUtil = NBPhoneNumberUtil()
    
    var phoneNumberResults : Bool = false
    
//    static var myphoneNumber = String()
//    static var PinStatus = String()
//    static var token = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        let topview = UILabel()
        topview.backgroundColor = mobiColor
        topview.frame = CGRect(x: 0 , y: 0, width: view.frame.size.width, height: view.frame.size.height/6)
        view.addSubview(topview)

        
        
        view.backgroundColor = UIColor.white
        phoneNumberField.addTarget(self, action: #selector(self.ck), for: .editingChanged)
        phoneNumberField.leftView = cp
        phoneNumberField.leftViewMode = .always
        phoneNumberField.placeholder = "手机号码"
        phoneNumberField.keyboardType = UIKeyboardType.numberPad
        phoneNumberField.frame = CGRect(x: view.frame.size.width/15.8, y: view.frame.size.height/3.6
            , width: view.frame.size.width/1.15, height: 40)
        phoneNumberField.delegate = self

        phoneNumberField.layer.addBorder(edge: .bottom, color: UIColor.groupTableViewBackground, thickness: 1)

        phoneNumberField.addTarget(self, action: #selector(self.change), for: .editingChanged)
        phoneNumberField.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(phoneNumberField)
        
        cp.showCountryCodeInView = false
        
//        let messagelab = UILabel()
//        messagelab.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
//        messagelab.text = "短信驗證碼"
//
//        let messageBtn = UIButton()
//        messageBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
//        messageBtn.setTitle("發送", for: .normal)
//        messageBtn.setTitleColor(UIColor.blue, for: .normal)
//        messageBtn.layer.addBorder(edge: .bottom, color: UIColor.blue, thickness: 1)
//
//        messageCode.rightView = messageBtn
//        messageCode.rightViewMode = .always
//
//        messageCode.leftView = messagelab
//        messageCode.leftViewMode = .always
//        messageCode.keyboardType = UIKeyboardType.numberPad
//        messageCode.frame = phoneNumberField.frame
//        messageCode.frame.origin.y += phoneNumberField.frame.height+10
//        messageCode.layer.addBorder(edge: .bottom, color: UIColor.groupTableViewBackground, thickness: 1)
//        view.addSubview(messageCode)
        
        let infolab = UILabel()
        infolab.frame = CGRect(x: 0, y: view.frame.size.height/2.9, width: self.view.frame.size.width, height: view.frame.size.height/14.2
        )
        infolab.text = "点击「下一步」即表示您同意使用协议和隐私政策"
        infolab.font = UIFont.systemFont(ofSize: 12)
        infolab.textAlignment = .center
        view.addSubview(infolab)
        
        nextBtn.frame = phoneNumberField.frame
        nextBtn.frame.origin.y =  view.frame.size.height/2.4
        nextBtn.addTarget(self, action: #selector(self.nextView), for: .touchUpInside)
        nextBtn.backgroundColor = UIColor.gray
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.layer.cornerRadius = 20
        view.addSubview(nextBtn)
        
        
        let view3ces = UILabel()
        view3ces.font = UIFont.boldSystemFont(ofSize: 20)
        view3ces.text = "欢迎使用电子钱包"
        view3ces.frame = view.frame
        view3ces.textAlignment = .center
        view3ces.textColor = UIColor.white
        view3ces.backgroundColor = mobiColor
        view.addSubview(view3ces)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            view3ces.removeFromSuperview()
            self.phoneNumberField.becomeFirstResponder()

        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    @objc func nextView(){
        
        do {

            let vs : String = try phoneUtil.format(phoneNumber, numberFormat: .E164)
            
            let defaults = UserDefaults.standard
            defaults.set(vs, forKey: "phoneNumber")
            defaults.synchronize()
            
            let defaults2 = UserDefaults.standard
            defaults2.set("1", forKey: "PinStatus")
            defaults2.synchronize()
            
            user.remove("PinNumber")
            let defaults3 = UserDefaults.standard
            defaults3.set("5", forKey: "PinNumber")
            defaults3.synchronize()
            
//            phoneNumberViewController.PinStatus = "1"
            
            if phoneNumberResults {
                
                setupView()
                
                Alamofire.request("https://twilio168.azurewebsites.net/api/HttpTriggerCSharp3?code=vsBbawBOQg3Ww0o7Mocv2mXOAcVwywv1NvCBGzmEkcGE5x9RXTHHcQ==&phoneNo=\(vs)").responseJSON { response in
                    if let Json = response.result.value {
                        // 回傳 yes
                        let ty = Json as![String:AnyObject]
                        let status = ty["status"]as! String
                        if status == "ok"{
                            self.loadviewBG.removeFromSuperview()

                            let vc = phoneVerificationViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                        // 回傳 do
                            self.alert(status,"關閉")
                        }
  
                    }else{
                        self.alert("連接異常","關閉")
                        self.loadviewBG.removeFromSuperview()
                    }
                }
            }else{
                self.alert("請輸入正確的手機號碼","關閉")
            }
        }
        catch let error as NSError {
            // alert 輸入 正確號碼
            print(error.localizedDescription)
            self.alert("請輸入正確的手機號碼","關閉")

        }
        

    }
    @objc func change(){

        //按件
    }
    
    @objc func alert(_ title:String , _ status:String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: status, style: .cancel, handler: { action in
            
        }))
        
        if let alertWindow = UIApplication.shared.windows.last, alertWindow.windowLevel == 10000001.0 // If keyboard is open
        { // Make sure keyboard is open
            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        }
        else
        {
            self.present(alert, animated: true)
        }
    }
    
    fileprivate func setupView() {
        phoneNumberField.resignFirstResponder()
        
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
    

    
    @objc func ck(){
//        print(phoneNumberField.text!)
        do {
            phoneNumber = try phoneUtil.parse(phoneNumberField.text!, defaultRegion:cp.selectedCountry.code)
            
             phoneNumberResults =  phoneUtil.isValidNumber(forRegion: phoneNumber, regionCode:cp.selectedCountry.code)
            
            if phoneNumberResults {
                nextBtn.backgroundColor = mobiColor
            }else{
                nextBtn.backgroundColor = UIColor.gray
            }
        }
        catch let error as NSError {
            // alert 輸入 正確號碼
            print(error.localizedDescription)
            print("sssss")
        }
        
        
    }
    


}

