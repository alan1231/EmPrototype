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
    let loadviewBG = UIView()

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
        textfield.becomeFirstResponder()
        textfield.textAlignment = .center

        view.addSubview(textfield)
        
        btn.frame = CGRect(x: view.frame.size.width/1.28, y: view.frame.size.height/28, width: view.frame.size.width/5, height: view.frame.size.height/20)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 1)
        btn.setTitle("下一步", for: .normal)
        btn.addTarget(self, action: #selector(self.sendName), for: .touchUpInside)
        view.addSubview(btn)
        
        
    }
    @objc func sendName (){
        print("1")
        textfield.resignFirstResponder()
        setupView()
        let str1 = self.textfield.text!
        //除去前后空格
        let str2 = str1.trimmingCharacters(in: .whitespaces)
            print(str2)
            print(user.get("Token"))
            APIManager.getApi.sendName(user.get("Token"), str2, completion: {result,err    in
                
                
                if result == "ok"{
                    self.loadviewBG.removeFromSuperview()
                    
                    let vc = tabbar()
//                    self.navigationController?.pushViewController(vc, animated: true)
                    self.present(vc, animated: false, completion: nil)
                   
                    
                }else{
                    self.loadviewBG.removeFromSuperview()
                    print(str2)
                    print(user.get("Token"))
                    //                self.messageTextField.becomeFirstResponder()
                    //                self.messageTextField.shake()
                    //                self.messageTextField.text = ""
                }
                if result == nil {
                    self.loadviewBG.removeFromSuperview()
                    print("含空")
                }
                
                
            })

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
