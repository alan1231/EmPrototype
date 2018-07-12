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
    
    let cp = CountryPickerView(frame: CGRect(x: 20, y: 220, width: 115, height: 20))
    
    let loadviewBG = UIView()
    
    var messageCode = UITextField()

    var  phoneNumberField = UITextField()
    
    static var myphoneNumber = String()
    static var PinStatus = String()
    static var token = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topview = UILabel()
        topview.backgroundColor = mobiColor
        topview.frame = CGRect(x: 0 , y: 0, width: view.frame.size.width, height: view.frame.size.height/6)
        view.addSubview(topview)

 
        
        view.backgroundColor = UIColor.white
        
        phoneNumberField.leftView = cp
        phoneNumberField.leftViewMode = .always
        phoneNumberField.placeholder = "手机号码"
        phoneNumberField.keyboardType = UIKeyboardType.numberPad
        phoneNumberField.frame = CGRect(x: 22, y: 160
            , width: view.frame.size.width/1.2, height: 40)

        phoneNumberField.layer.addBorder(edge: .bottom, color: UIColor.groupTableViewBackground, thickness: 1)

        phoneNumberField.addTarget(self, action: #selector(self.change), for: .editingChanged)
        phoneNumberField.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(phoneNumberField)
        phoneNumberField.becomeFirstResponder()
        
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
        infolab.frame = CGRect(x: 0, y: 265, width: self.view.frame.size.width, height: 40)
        infolab.text = "点击「下一步」即表示您同意使用协议和隐私政策"
        infolab.font = UIFont.systemFont(ofSize: 12)
        infolab.textAlignment = .center
        view.addSubview(infolab)
        
        let nextBtn = UIButton()
        nextBtn.frame = phoneNumberField.frame
        nextBtn.frame.origin.y = 300
        nextBtn.addTarget(self, action: #selector(self.nextView), for: .touchUpInside)
        nextBtn.backgroundColor = mobiColor
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.layer.cornerRadius = 20
        view.addSubview(nextBtn)
        

        
//        let request = URLRequest(url: NSURL(string: "https://twilio168.azurewebsites.net/api/HttpTriggerCSharp3?code=vsBbawBOQg3Ww0o7Mocv2mXOAcVwywv1NvCBGzmEkcGE5x9RXTHHcQ==&phoneNo=886978768913")! as URL)
//        do {
//            // Perform the request
//            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
//            let data = try? NSURLConnection.sendSynchronousRequest(request, returning: response)
//
//            // Convert the data to JSON
//            let jsonSerialized = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
//
//            if let json = jsonSerialized, let url = json!["status"] {
//                print("@@@:\(url as! String)")
//            }
//        }


    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @objc func nextView(){
        let phoneUtil = NBPhoneNumberUtil()
        
        do {
            let phoneNumber: NBPhoneNumber = try phoneUtil.parse(phoneNumberField.text!, defaultRegion:cp.selectedCountry.code)

            let phoneNumberResults =  phoneUtil.isValidNumber(forRegion: phoneNumber, regionCode:cp.selectedCountry.code)
            
            
            let vs : String = try phoneUtil.format(phoneNumber, numberFormat: .E164)
            phoneNumberViewController.myphoneNumber = vs
            phoneNumberViewController.PinStatus = "1"

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
    
    
    


}

