//
//  setNameViewController.swift
//  EmPrototype
//
//  Created by alan on 2018/7/11.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class setNameViewController: UIViewController {
    let textfield = UITextField()
    let btn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = mobiColor
        navigationController?.navigationBar.isHidden = true
        
        let nameLab = UILabel()
        nameLab.frame = CGRect(x: 0, y: view.frame.size.height/10, width: view.frame.size.width, height: view.frame.size.height/10)
        nameLab.text = "请输入姓名"
        nameLab.textAlignment = .center
        nameLab.font = UIFont.boldSystemFont(ofSize: 30)
        nameLab.textColor = UIColor.white
        view.addSubview(nameLab)
        
        let image = UIImageView()
        image.image =  UIImage(named: "icon.png")
        image.frame = CGRect(x: view.frame.width/2-((view.frame.size.width/4)/2), y:view.frame.size.height/4 , width: view.frame.size.width/4, height: view.frame.size.width/4)
        view.addSubview(image)
        
        textfield.frame = CGRect(x: view.frame.size.width/10, y: view.frame.size.height/2.15, width: view.frame.size.width - ((view.frame.size.width/10)*2), height: view.frame.size.height/13)
        textfield.backgroundColor = UIColor.white
        textfield.textAlignment = .center
        self.textfield.becomeFirstResponder()

        view.addSubview(textfield)
        
        btn.frame = CGRect(x: view.frame.size.width/1.28, y: view.frame.size.height/28, width: view.frame.size.width/5, height: view.frame.size.height/20)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        btn.setTitle("完成", for: .normal)
        btn.addTarget(self, action: #selector(self.sendName), for: .touchUpInside)
        view.addSubview(btn)
        
        
    }
    @objc func sendName (){
        textfield.resignFirstResponder()
        setupView(view)
        let str1 = self.textfield.text!
        //除去前后空格
        let str2 = str1.trimmingCharacters(in: .whitespaces)

            APIManager.getApi.sendName( str2, completion: {result,errors    in
                

                if result == true {
                    user.save("Name", str2)
                    stoploadingView()
                    let vc = homeViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.navigationController?.navigationBar.isHidden = true
                    
                }else{
                    stoploadingView()
                    self.textfield.becomeFirstResponder()
                    self.textfield.shake()
                    //                self.messageTextField.becomeFirstResponder()
                    //                self.messageTextField.shake()
                    //                self.messageTextField.text = ""
                }
                if result == false {
                    stoploadingView()
                    self.textfield.becomeFirstResponder()
                    self.textfield.shake()
                    print(errors as Any)
                }
                
                
            })

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
