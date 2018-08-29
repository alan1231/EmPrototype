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
    let serviceToken = ""
    static let getApi = APIManager()
    

    //傳送手機號碼
    func sendPhoneNumber(_ Number:String,_ name:String,completion:@escaping (String?,Error?)->Void){
        let url = "https://uwfuncapp.azurewebsites.net/api/reqSmsVerify?phoneno=\(Number)"
        Alamofire.request(url).responseJSON { response in
        
            if let Json = response.result.value {
                // 回傳 yes
                let ty = Json as![String:AnyObject]
                let status = "\(String(describing: ty["statusCode"]!))"

                if status == "200"{
                    print("!!!!!!!")
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
    
    
    //傳送簡訊認證碼
    func sendMessage(_ phoneNumber:String,_ smsCode:String,completion:@escaping (String?,String?,Error?)->Void){
        
        let ary = ["phoneno" : "\(phoneNumber)","passcode": "\(smsCode)"] as [String : Any]
        let parameters2: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.login)","params":ary,"id":1]
        
        Alamofire.request("\(API_URL)\(API_AUTH)", method: .post ,parameters:parameters2 , encoding: JSONEncoding.default).responseJSON{ response in
            
            if let Json = response.result.value {
                print(Json)
                let ty = Json as![String:AnyObject]
                if let token = ty["result"]!["token"]{
                    print(token as Any)
                    completion((token as! String),"ok",nil)
                }else{
                    completion(nil,"err",nil)
                }
                

            }
            
        }
        
     }

    //檢查token(JWT)是否仍有效
    func cheackToken(completion:@escaping([String:AnyObject]?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.isTokenAvailable)","params":ary,"id":301]
        
        Alamofire.request("\(API_URL)\(API_AUTH)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            if response.result.value != nil {
                if let Json = response.result.value {
                    let JsData = Json as![String:AnyObject]
                    completion(JsData)
                }
            }else{
                completion(nil)
                
            }
            
        }
    }

    
    //設定名字
    func sendName(_ name:String,completion:@escaping (Bool?,String?)->Void){
        let params = ["keys" : ["name"],"values": ["\(name)"]] as [String : Any]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.updateProfile)","params":params,"id":1]
        Alamofire.request("\(API_URL)\(API_PROFILE)", method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"])
            .responseJSON { response in
                if let Json = response.result.value {
                    let JsonStr = Json as![String:AnyObject]
                    if let result = JsonStr["result"]{
                        completion((result as? Bool),nil)
                    }else{
                        completion(false,(JsonStr["error"] as! String))
                    }
                    
                    
                }
                
        }
 
    }
    
    //取得聯絡人名單
    
    func getUserList(_ int:Int , completion:@escaping([String:AnyObject]?,String?)->Void){
        let ary = [String]()
        
        let parameters: Parameters = ["jsonrpc":"2.0","method":"getAllUsers","params":ary,"id":int]
        
        Alamofire.request("\(API_URL)\(API_CONTACT)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            
            if let Json = response.result.value {
                print(Json)
                
                completion((Json as! [String : AnyObject]),nil)

            }else{
                
                completion(nil,"err")
                
            }
            
        }
    }
    
    
    //手機device token 推播傳送碼
    func sendDevicetoken(_ devicetoken:String,completion:@escaping (Bool?)->Void){
        let params = ["pns" : "apns","pnsToken": "\(devicetoken)"] as [String : Any]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.regPnsToken)","params":params,"id":1]
        
        Alamofire.request("\(API_URL)\(API_NOTIFICATION)", method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"])
            .responseJSON { response in
                if let Json = response.result.value {
                    print(Json)
                    let JsonStr = Json as![String:AnyObject]
                    if let result = JsonStr["result"]{
                        completion((result as! Bool))
                    }else{
                        completion(nil)
                    }
                    
                }
        }
    }

    //個人推播 指定 訊息
    func sendSingleMessage(_ userid:String,_ message:String,completion:@escaping(Bool?)->Void){
        let ary = ["userId" : "\(userid)","message":"\(message)"] as [String : Any]
        
        let parameters: Parameters = ["jsonrpc":"2.0","method":"sendMessage","params":ary,"id":1]
        
        Alamofire.request("\(API_URL)\(API_NOTIFICATION)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            if response.result.value != nil {
                completion(true)
            }else{
                completion(false)
            }
            
        }
    }
    //取得餘額
    func getBalances(completion:@escaping([String:AnyObject]?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.getBalances)","params":ary,"id":301]
        
        Alamofire.request("\(API_URL)\(API_TRADING)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            if response.result.value != nil {
                if let Json = response.result.value {
                    let JsData = Json as![String:AnyObject]
                    completion(JsData)
                }
                }else{
                    completion(nil)

            }
            
        }
    }
    
    //付款/轉帳

    func payBalances(_ currency:String, _ amount:String,_ toUserId:String,completion:@escaping([String:AnyObject]?)->Void){
        
        let ary = ["currency" : "\(currency)","amount":"\(amount)","toUserId":"\(toUserId)"] as [String : Any]
        
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.transfer)","params":ary,"id":301]
        
        Alamofire.request("\(API_URL)\(API_TRADING)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            if response.result.value != nil {
                if let Json = response.result.value {
                    print(Json
                    )
                    let JsData = Json as![String:AnyObject]
                    completion(JsData)
                }
            }else{
                completion(nil)
                
            }
            
        }
    }
    
    
    //取得個人設定
    func getProfile(completion:@escaping(String?,Data?,String?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"getProfile","params":ary,"id":4]
        
        Alamofire.request("\(API_URL)\(API_PROFILE)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            if let Json = response.result.value {
                print(Json)
                let JsData = Json as![String:AnyObject]
                let name = JsData["result"]!["name"]
                let imageUrlString = JsData["result"]!["avatar"]
                if let imageUrl = URL(string: imageUrlString as! String) {

                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in

                        if error != nil {

                            print("Download Image Task Fail: \(error!.localizedDescription)")
                        }
                        else if let imageData = data {

                            DispatchQueue.main.async {
                                completion((name as! String),imageData,"ok")
                            }
                        }

                    }).resume()
                }
                
                
            }else{
            }
            
        }
    }
    
  

}
