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
        Alamofire.request("https://twilio168.azurewebsites.net/api/HttpTriggerSmsCheck?code=G/HlMKjalgY5r0GXahXfaWQ2aVnVypkmowdUXUEsOUEfmheOCcaXLw==&phoneNo=\(phoneNumber)&smsCode=\(smsCode)").responseJSON { response in
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
        
        let url = "https://twilio168.azurewebsites.net/api/HttpTriggerInputName?code=32npjc/WSfYFIRnzVtz/F8ezvoalEjc0DMt8Z1ovaiCKUoXkYteSJA==&token=\(token)&name=\(name)"
        
        let urlstr = url.urlEncoded()
        
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
//                var error: Error? {
//                    return 1 as! Error
//
//                }
                let e = NSError(domain:"", code:1)
                completion(nil, e)
                
            }
        }
        
    }
    
    
    
}
