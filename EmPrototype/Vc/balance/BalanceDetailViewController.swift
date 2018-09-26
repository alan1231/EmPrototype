//
//  BalanceDetail.swift
//  EmPrototype
//
//  Created by alan on 2018/9/13.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class BalanceDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var myNumberTextField = UITextField()
    var messageTextField = UITextField()
    var myTextField = UITextField()

    
    var strtitle : String?
    let fullScreenSize = UIScreen.main.bounds.size
    var meals = ["USD","BTC","ETH","CNY"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strtitle

        meals = meals.filter({(str1) -> Bool in
            return str1 != strtitle
        })
        
        
        // 建立一個 UITextField
        let selectlab = UILabel()
        selectlab.frame = CGRect(x: 0, y: 80, width: fullScreenSize.width, height: 40)
        selectlab.text = "選擇幣別"
        selectlab.textAlignment = .center
        view.addSubview(selectlab)
        
        myTextField = UITextField(frame: CGRect(x: 0, y: 120, width: fullScreenSize.width, height: 40))
        
        // 建立 UIPickerView
        let myPickerView = UIPickerView()
        
        // 設定 UIPickerView 的 delegate 及 dataSource
        myPickerView.delegate = self
        myPickerView.dataSource = self
        
        // 將 UITextField 原先鍵盤的視圖更換成 UIPickerView
        myTextField.inputView = myPickerView
        
        // 設置 UITextField 預設的內容
        
        // 設置 UITextField 的 tag 以利後續使用
        
        // 設置 UITextField 其他資訊並放入畫面中
        myTextField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        myTextField.textAlignment = .center
        myTextField.text = meals[0]
        view.addSubview(myTextField)

        view.backgroundColor = UIColor.white
        
        let selectNumber = UILabel()
        selectNumber.frame = CGRect(x: 0, y: 160, width: fullScreenSize.width, height: 40)
        selectNumber.text = "選擇金額"
        selectNumber.textAlignment = .center
        view.addSubview(selectNumber)
        
        myNumberTextField = UITextField(frame: CGRect(x: 0, y: 200, width: fullScreenSize.width, height: 40))
        myNumberTextField.tag = 120
        myNumberTextField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        myNumberTextField.textAlignment = .center
        myNumberTextField.placeholder = "輸入金額"
        myNumberTextField.keyboardType = UIKeyboardType.decimalPad
        view.addSubview(myNumberTextField)
        
        let selectmseeage = UILabel()
        selectmseeage.frame = CGRect(x: 0, y: 240, width: fullScreenSize.width, height: 40)
        selectmseeage.text = "message"
        selectmseeage.textAlignment = .center
        view.addSubview(selectmseeage)
        
        messageTextField = UITextField(frame: CGRect(x: 0, y: 280, width: fullScreenSize.width, height: 40))
        messageTextField.tag = 140
        messageTextField.textAlignment = .center
        messageTextField.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        messageTextField.placeholder = "輸入message"
        view.addSubview(messageTextField)
    
        
        
        let sendBtn = UIButton()
        sendBtn.frame = CGRect(x: 0, y: 320, width: fullScreenSize.width, height: 40)
        sendBtn.setTitle("確定發送", for:.normal)
        sendBtn.addTarget(self, action:#selector(self.doExFrom), for: .touchUpInside)
        sendBtn.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(sendBtn)
        
        // 增加一個觸控事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard(tapG:)))
        
        tap.cancelsTouchesInView = false
        
        // 加在最基底的 self.view 上
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func doExFrom(){
        setupView((self.navigationController?.view)!)

        if myNumberTextField.text == "" {
            let alert = UIAlertController(title: "警告視窗", message: "金額未填", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK!", style: .default) { (UIAlertAction) in
                stoploadingView()
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)        }else{
            APIManager.getApi.doExFrom(strtitle!,myTextField.text!,myNumberTextField.text!,messageTextField.text!,completion:{
                err, result in
                stoploadingView()
            })
        }
        
      

    }
    
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 各列有多少行資料
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return meals.count
    }
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 設置為陣列 meals 的第 row 項資料
        return meals[row]
    }
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 依據元件的 tag 取得 UITextField
//        let myTextField = self.view?.viewWithTag(100) as? UITextField
        
        // 將 UITextField 的值更新為陣列 meals 的第 row 項資料
        myTextField.text = meals[row]
    }
    // 按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.placeholder == "輸入金額"{
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            let expression = "^\\d{0,10}(\\.\\d{0,8})?$"
            let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
            let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
            return numberOfMatches != 0
        }
        
        return true
        
    }

}
