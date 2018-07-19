//
//  APIManager.swift
//  EmPrototype
//
//  Created by alan on 2018/7/10.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Alamofire
class APIManager: NSObject {
    
    static let getApi = APIManager()
    
    
    func sendMessage(_ phoneNumber:String,_ smsCode:String,completion:@escaping (String?,String?,Error?)->Void){
        Alamofire.request("https://davidfunc.azurewebsites.net/api/verifySMSPasscode?code=lECM7Qzk08hMeMLmqIbosIfqQzHXAmZcialbxsT658huTitp8WUqxQ==&phoneNo=\(phoneNumber)&smsCode=\(smsCode)").responseJSON { response in
            if let Json = response.result.value {
                // 回傳 yes
                print(Json)
                let ty = Json as![String:AnyObject]
                let status = ty["status"]as! String
                let token = ty["token"]as! String

                if status == "ok"{
                    completion(status,token, nil)
                }else{
                    completion(status,token, nil)
                }
                
            }else{
    
                }
        }
        
     }
    
    func sendName(_ token:String,_ name:String,completion:@escaping (String?,Error?)->Void){
        let url = "https://davidfunc.azurewebsites.net/api/setUsername?code=lXyuIVo6awl56MAo2kIBF3NT1e9rMw4X5ybecNHrawksrKOHzC/XuQ==&token=\(token)&name=\(name)"
        let urlstr = url.urlEncoded()
        
        print(urlstr)
        
        print(url+";")
        Alamofire.request(urlstr).responseJSON { response in
            

            if let Json = response.result.value {
                // 回傳 yes
                print(Json)
                let ty = Json as![String:AnyObject]
                let status = ty["status"]as! String
                if status == "ok"{
                    completion(status, nil)
                }else{
                    
                    completion(status, nil)
                    print(Json)


                }
                
            }else{
                let e = NSError(domain:"", code:1)
                completion(nil, e)
                print(e)
                
            }
        }
        
    }
    
    
    
}
