//
//  pinCodeViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/6/29.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class pinCodeViewController: UIViewController,UITextFieldDelegate {
        var pinTextField = UITextField()
        var labAry = [UILabel]()
    var labview = UIView()
        var codeNumber : Int = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        self.title = "輸入PIN"
        let newBackButton = UIBarButtonItem(title:nil, style: UIBarButtonItem.Style.done, target: self, action:nil)
        self.navigationItem.leftBarButtonItem = newBackButton
        
    
        
        let accountLeftView = UIView()
        accountLeftView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        pinTextField.leftViewMode = .always
        pinTextField.leftView = accountLeftView
        pinTextField.frame = CGRect(x: 27, y: 220, width: 321, height: 56)
        pinTextField.becomeFirstResponder()
        pinTextField.keyboardType = UIKeyboardType.numberPad
        pinTextField.backgroundColor = UIColor.white
        pinTextField.layer.borderWidth = 1
        pinTextField.delegate = self
        pinTextField.layer.borderColor = UIColor.gray.cgColor
        pinTextField.placeholder = "輸入4位PIN"
        pinTextField.isHidden = true
        view.addSubview(pinTextField)

        
        let nextBtn = UIButton()
        nextBtn.frame = CGRect(x: 140, y: 400, width: 100, height: 40)
        nextBtn.addTarget(self, action: #selector(self.pinAlert), for: .touchUpInside)
        nextBtn.backgroundColor = UIColor.white
        nextBtn.setTitle("PIN選項", for: .normal)
        nextBtn.setTitleColor(UIColor(red: 41/255, green: 125/255, blue: 245/255, alpha: 1), for: .normal)
        view.addSubview(nextBtn)
        
        
            self.labview.center = self.view.center
            self.labview.frame.size.width = 230
            self.labview.frame.size.height = 30
            self.labview.frame.origin.x = self.labview.frame.origin.x - 120
            self.labview.frame.origin.y = self.labview.frame.origin.y - 180
            self.view.addSubview(self.labview)
        
        for index in 0...5 {
            let uilab = UILabel()
            uilab.frame = CGRect(x: 0+(40*index), y: 0, width: 30, height: 30)
            uilab.textAlignment = .center
            uilab.font = UIFont.systemFont(ofSize: 40)
            uilab.layer.addBorder(edge: .bottom, color: UIColor.black, thickness: 2)
            self.labview.addSubview(uilab)
            self.labAry.append(uilab)
        }
        
    
        
    }
    @objc func pinAlert(){

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)

        let number4Code = UIAlertAction(title:"4位數密碼", style: .default, handler: {action in
            
            self.codeNumber = 3
            self.labview.removeFromSuperview()
            self.labview = UIView()

            self.labAry.removeAll()
            
            self.labview.center = self.view.center
            self.labview.frame.size.width = 150
            self.labview.frame.size.height = 30
            self.labview.frame.origin.x = self.labview.frame.origin.x - 80
            self.labview.frame.origin.y = self.labview.frame.origin.y - 180
            self.view.addSubview(self.labview)
            
            for index in 0...self.codeNumber {
                let uilab = UILabel()
                uilab.frame = CGRect(x: 0+(40*index), y: 0, width: 30, height: 30)
                uilab.textAlignment = .center
                uilab.font = UIFont.systemFont(ofSize: 15)
                uilab.layer.addBorder(edge: .bottom, color: UIColor.black, thickness: 3)
                self.labview.addSubview(uilab)
                self.labAry.append(uilab)
                print(index)
            }
        })
        
        let number6Code = UIAlertAction(title:"6位數密碼", style: .default, handler: {action in
            self.codeNumber = 5
            self.labview.removeFromSuperview()
            self.labview = UIView()
            self.labAry.removeAll()
            self.labview.center = self.view.center
            self.labview.frame.size.width = 230
            self.labview.frame.size.height = 30
            self.labview.frame.origin.x = self.labview.frame.origin.x - 120
            self.labview.frame.origin.y = self.labview.frame.origin.y - 180
            self.view.addSubview(self.labview)
            
            for index in 0...self.codeNumber {
                let uilab = UILabel()
                uilab.frame = CGRect(x: 0+(40*index), y: 0, width: 30, height: 30)
                uilab.textAlignment = .center
                uilab.font = UIFont.systemFont(ofSize: 15)
                uilab.layer.addBorder(edge: .bottom, color: UIColor.black, thickness: 3)
                self.labview.addSubview(uilab)
                self.labAry.append(uilab)
            }
            
            //更換 lab 顯示數
        })
        alertController.addAction(number4Code)
        alertController.addAction(number6Code)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print(string)
        
        switch range.location {
        case 0:
            labAry[0].text = "*"
        case 1:
            labAry[1].text = "*"
        case 2:
            labAry[2].text = "*"
        case 3:
            labAry[3].text = "*"
        case 4:
            labAry[4].text = "*"
        case 5:
            labAry[5].text = "*"
        default: break
        }
        
        
        if codeNumber == range.location{
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.4) {
                
                let vc = pinCodeAgainViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            


         
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    @objc func back(sender: UIBarButtonItem) {
//        self.navigationController?.popViewController(animated: true)
//    }

}
