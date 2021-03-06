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
class phoneNumberViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    let cp = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 125, height: 20))
    var messageCode = UITextField()
    var  phoneNumberField = UITextField()
    let nextBtn = UIButton()
    var phoneNumber = NBPhoneNumber()
    var phoneUtil = NBPhoneNumberUtil()
    var phoneNumberResults : Bool = false
    
    
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
        
        let infolab = UITextView()
        infolab.frame = CGRect(x: 0, y: phoneNumberField.frame.origin.y + phoneNumberField.frame.height + 10, width: self.view.frame.size.width, height: view.frame.size.height/18
        )
        infolab.appendLinkString(string: "点击「下一步」即表示您同意")
        infolab.appendLinkString(string: "使用协议", withURLString: "UseAgreement:")
        infolab.appendLinkString(string: "和")
        infolab.appendLinkString(string: "隐私政策", withURLString: "PrivacyPolicy:")


        infolab.font = UIFont.systemFont(ofSize: 12)
        infolab.textAlignment = .center
        infolab.delegate = self
        infolab.isUserInteractionEnabled = true
        infolab.isEditable = false
        
        view.addSubview(infolab)
        
        nextBtn.frame = phoneNumberField.frame
        nextBtn.frame.origin.y =  infolab.frame.origin.y + infolab.frame.size.height
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
    func textView(_ textView: UITextView, shouldInteractWith URL: URL,
                  in characterRange: NSRange) -> Bool {
        
        switch URL.scheme {
        case "UseAgreement" :
            let vc = AgreementViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case "PrivacyPolicy" :
            let vc = PrivacyPolicyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    

    
    @objc func nextView(){
        
        do {

            var vs : String = try phoneUtil.format(phoneNumber, numberFormat: .E164)
            vs = vs.replacingOccurrences(of: "+", with: "")

            user.save("PhoneNumber",vs)
            user.save("PinNumber", "5")
            user.save("PinStatus", "1")
            
            if phoneNumberResults {
               
                phoneNumberField.resignFirstResponder()
                
                
                setupView(view)
                APIManager.getApi.sendPhoneNumber(vs, completion: { result,err   in
                    if (result)!{
                        print("ok")
                        stoploadingView()
                        let vc = phoneVerificationViewController()
                        vc.phoneStr = "\(self.cp.selectedCountry.phoneCode) \(self.phoneNumberField.text!)"
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let er = err["error"] as! [String:Any]
                        self.alert("\(er["message"]!)","關閉")
                        stoploadingView()                    }
                    
                })

                
            }else{
                self.alert("請輸入正確的手機號碼","關閉")
            }
        }
        catch let error as NSError {
            // alert 輸入 正確號碼
            print(error.localizedDescription)
//            self.alert("請輸入正確的手機號碼","關閉")

        }
        

    }
    @objc func change(){

        //按件
    }
    
    @objc func alert(_ title:String , _ status:String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: status, style: .cancel, handler: { action in
            
        }))
        

        self.present(alert, animated: true)

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
        }
        
        
    }
    


}


