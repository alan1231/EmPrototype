//
//  Json-Rpc.swift
//  EmPrototype
//
//  Created by alan on 2018/8/8.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Alamofire

class Json_Rpc: UIViewController {
    let top = UIView()
    let message = UILabel()
    let messagefield = UITextField()
    let phoneNumber = UILabel()
    let phoneNumberfield = UITextField()

    let senBtn = UIButton()
    
    let boot = UIView()
    let request = UILabel()
    let requestTextView = UITextView()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        top.frame = CGRect(x: 20, y: 30, width: 374, height: 222)
        top.backgroundColor = UIColor(red: 135/255, green: 204/255, blue: 255/255, alpha: 1)
        view.addSubview(top)
        
        message.frame = CGRect(x: 31, y: 16, width: 312, height: 21)
        message.text = "name"
        message.textAlignment = .center
        top.addSubview(message)
        
        messagefield.frame = CGRect(x: 31, y: 45, width: 312, height: 30)
        messagefield.textAlignment = .center
        messagefield.backgroundColor = UIColor.white
        top.addSubview(messagefield)
        
        phoneNumber.frame = CGRect(x: 31, y: 83, width: 312, height: 21)
        phoneNumber.text = "id"
        phoneNumber.textAlignment = .center
        top.addSubview(phoneNumber)
        
        phoneNumberfield.frame = CGRect(x: 31, y: 112, width: 312, height: 30)
        phoneNumberfield.textAlignment = .center
        phoneNumberfield.backgroundColor = UIColor.white
        top.addSubview(phoneNumberfield)
        
        senBtn.frame = CGRect(x: 137, y: 164, width: 101, height: 30)
        senBtn.setTitle("Send", for: .normal)
        senBtn.backgroundColor = UIColor(red: 253/255, green: 172/255, blue: 44/255, alpha: 1)
        senBtn.setTitleColor(.black, for: .normal)
        top.addSubview(senBtn)
        
        boot.frame = CGRect(x: 20, y: 322, width: 374, height: 226)
        boot.backgroundColor = UIColor(red: 253/255, green: 182/255, blue: 193/255, alpha: 1)
        view.addSubview(boot)
        
        request.frame = CGRect(x: 158, y: 14, width: 59, height: 21)
        request.text = "request"
        request.textAlignment = .center
        boot.addSubview(request)
        
        requestTextView.frame = CGRect(x: 22, y: 49, width: 333, height: 146)
        requestTextView.textAlignment = .center
        requestTextView.isEditable = false
        requestTextView.isSelectable = false

        boot.addSubview(requestTextView)
        
        
        var token = ""
        
        let art2 = ["phoneno" : "+886978768913","passcode": 3333,"devicetoken":"devicetoken"] as [String : Any]
        
        let parameters2: Parameters = ["jsonrpc":"2.0","method":"login","params":art2,"id":1]
        
        Alamofire.request("https://uwbackend-asia.azurewebsites.net/api/auth", method: .post ,parameters:parameters2 , encoding: JSONEncoding.default).responseJSON{ response in
            
            if let Json = response.result.value {
                let ty = Json as![String:AnyObject]
                token = ty["result"]!["token"] as! String
                print(token)
            }
            
        }
        
     
        
        let art = ["a": 2,"b": 3]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"MethodResult","params":art,"id":2]
     

        Alamofire.request("https://uwbackend-asia.azurewebsites.net/api/math", method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: ["Authorization": " Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6Iis4ODY5Nzg3Njg5MTMiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zaWQiOiIrODg2OTc4NzY4OTEzIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6Iis4ODY5Nzg3Njg5MTMiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJ1c2VyIiwiZGV2aWNldG9rZW4iOiJkZXZpY2V0b2tlbiIsImlzcyI6InhpbndhbmciLCJhdWQiOiJ1d2FsbGV0In0.4LzFqyIiM0Pxyzjf3tXxBuCY4KEEC5ecQOgCXF1C5gM"])
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
//                print("Progress: \(progress.fractionCompleted)")
            }.responseJSON { response in
//                print(response.result.value!)
        }
        
   
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
