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
    func sendPhoneNumber(_ number:String,completion:@escaping (Bool?,[String:Any])->Void){
        let params = ["phoneno" : "\(number)"] as [String : Any]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.reqSmsVerify)","params":params,"id":randomInt()]
        Alamofire.request("\(API_NUMBER)\(API_REQSMSVERITY)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let Json = response.result.value {
                    let JsonStr = Json as![String:AnyObject]
                    if JsonStr["error"]is NSNull{
                        completion(true,JsonStr)
                    }else{
                        completion(false,JsonStr)
                    }
                    
                }
                
        }
        
    }
    

    
    
    //傳送簡訊認證碼
    func sendMessage(_ phoneNumber:String,_ smsCode:String,_ devicetoken:String,completion:@escaping (String?,String?,Error?)->Void){
        
        let ary = ["phoneno" : "\(phoneNumber)","passcode": "\(smsCode)","pns": "apns","pnsToken":"\(devicetoken)"] as [String : Any]
        let parameters2: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.login)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_AUTH)", method: .post ,parameters:parameters2 , encoding: JSONEncoding.default).responseJSON{ response in
            
            if let Json = response.result.value {
                let ty = Json as![String:AnyObject]
                if let token = ty["result"]!["token"]{
                    print(token as! String)
                    completion((token as! String),"ok",nil)
                }else{
                    completion(nil,"err",nil)
                }
                

            }
            
        }
        
     }

    //檢查token(JWT)是否仍有效
    func cheackToken(completion:@escaping(Bool?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.isTokenAvailable)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_AUTH)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            if response.result.value != nil {
                print(response)
                if let Json = response.result.value {
                    let JsData = Json as![String:AnyObject]
                    
                    if !(JsData["error"] is NSNull){

                    }
                    else{
                        let cheack = JsData["result"]!["available"] as! Bool
                        if (cheack){
                            completion(cheack)
                        }else{
                            completion(cheack)
                        }
                    }
                }
            }else{
                // 連接失敗 動作
            }
            
        }
    }
    
    
    //設定名字
    func sendName(_ name:String,completion:@escaping (Bool?,String?)->Void){
        let params = ["keys" : ["name"],"values": ["\(name)"]] as [String : Any]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.updateProfile)","params":params,"id":randomInt()]
        Alamofire.request("\(API_URL)\(API_PROFILE)", method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"])
            .responseJSON { response in
                if let Json = response.result.value {
                    let JsonStr = Json as![String:AnyObject]
                    if JsonStr["error"]is NSNull{
                        completion(true,nil)
                    }else{
                        completion(false,(JsonStr["error"] as! String))
                    }
                }
            }
    }
    //新增聯絡人
    func addFriends(_ ary:[String],completion:@escaping([String:AnyObject]?)->Void){
        let ary = ["list":ary]
        print(ary)
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.addFriends)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_CONTACT)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            print(response)
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                //處理失敗
                return
            }
            
            //檢查結果
            let rate = jr.result
            completion(rate)
        }
    }
    
    //刪除聯絡人
    func delFriends(_ ary:[String],completion:@escaping(Bool,[String:AnyObject]?)->Void){
        let ary = ["list":ary]
        print(ary)
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.delFriends)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_CONTACT)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            print(response)
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                completion(false,nil)
                //處理失敗
                return
            }
            
            //檢查結果
            let rate = jr.result
            completion(true,rate)
        }
    }
    //取得聯絡人名單
    func getContacts(completion:@escaping(Bool, FriendData?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.getContacts)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_CONTACT)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                completion(false, nil)

                //處理失敗
                return
            }
            
            //檢查結果
            let res = jr.result!
            
            let list = FriendData(JSON: res)

            completion(true, list)
     }
    }
    
    //取得用戶資料
    func getUsersProfile(_ ary:[String],completion:@escaping(_ err:Bool, UsersProfileData?)->Void){
        let ary = ["userIds":ary]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.getUsersProfile)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_PROFILE)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                completion(false, nil)
                
                //處理失敗
                return
            }
            
            //檢查結果
            let res = jr.result!
            
            let list = UsersProfileData(JSON: res)
            
            completion(true, list)
        }
    }



    
    
    //取得所有用戶列表（測試用途）
    func getUserList(completion:@escaping(Bool, FriendData?)->Void){
        let ary = [String]()
        
        let parameters: Parameters = ["jsonrpc":"2.0","method":"getAllUsers","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_CONTACT)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                completion(false, nil)

                //處理失敗
                return
            }
            
            //檢查結果
            let rate = jr.result!
            APIData.instance.firend = FriendData(JSON: rate)
            let list = FriendData(JSON: rate)

            completion(true,list)
        }
    }
    
    
    //手機device token 推播傳送碼
    func sendDevicetoken(_ devicetoken:String,completion:@escaping (AnyObject?)->Void){
        let params = ["pns" : "apns","pnsToken": "\(devicetoken)"] as [String : Any]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.regPnsToken)","params":params,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_NOTIFICATION)", method: .post, parameters: parameters, encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"])
            .responseJSON { response in
                if let Json = response.result.value {
                    let JsonStr = Json as![String:AnyObject]
                    if let result = JsonStr["result"]{
                        completion(result)
                    }else{
                        completion(nil)
                    }
                    
                }
        }
    }

    //個人推播 指定 訊息
    func sendSingleMessage(_ userid:String,_ message:String,completion:@escaping(Bool?)->Void){
        let ary = ["userId" : "\(userid)","message":"\(message)"] as [String : Any]
        
        let parameters: Parameters = ["jsonrpc":"2.0","method":"sendMessage","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_NOTIFICATION)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            if response.result.value != nil {
                completion(true)
            }else{
                completion(false)
            }
            
        }
    }
    //查詢交易紀錄
    func getReceipts(_ str:String,completion:@escaping([String:AnyObject]?)->Void){
        let ary = ["fromDatetime":str]
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.getReceipts)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_TRADING)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            print(response)
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                //處理失敗
                return
            }
            
            //檢查結果
            let rate = jr.result!
            completion(rate)
//            print(rate)
        }
    }
    //取得餘額
    func getBalances(completion:@escaping([String:AnyObject]?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.getBalances)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_TRADING)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                //處理失敗
                return
            }
            
            //檢查結果
            let rate = jr.result!
            completion(rate)

            
        }
    }
    
    //付款/轉帳

    func payBalances(_ currency:String, _ amount:String,_ toUserId:String,_ message:String,completion:@escaping([String:AnyObject]?)->Void){
        
        let ary = ["currency" : "\(currency)","amount":"\(amount)","toUserId":"\(toUserId)","message":"\(message)"] as [String : Any]
        print(ary)
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.transfer)","params":ary,"id":randomInt()]
        
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
    func getProfile(completion:@escaping(String?,URL?,String?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.getProfile)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_PROFILE)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            if let Json = response.result.value {
                print(Json)
                let JsData = Json as![String:AnyObject]
                let name = JsData["result"]!["name"]
                let userid = JsData["result"]!["userId"]
                user.save("username", name as! String)
                user.save("userid",userid as! String)
                let imageUrlString = JsData["result"]!["avatar"]
                if let imageUrl = URL(string: imageUrlString as! String) {

                    completion((name as! String),imageUrl,"ok")


                    }
                }
                
                
            }
            
        }
    
    
    func handleError(_ err:Int){
        
    }
    
    //取得匯率
    func getExRate(completion:@escaping([String:AnyObject]?)->Void){
        let ary = [String]()
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.getExRate)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_EXCURRENCY)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in

            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                //處理失敗
                return
            }
            
            //檢查結果
            let rate = jr.result!
            print(rate)
            completion(rate)
            
        }
    }
    //執行換匯
    func doExFrom(_ from:String, _ to:String, _ fromAmount:String, _ message:String,completion:@escaping(Bool,[String:AnyObject]?)->Void){
        let ary = ["fromCurrency":"\(from)","toCurrency":"\(to)","fromAmount":"\(fromAmount)","message":"\(message)"]
        print(ary)
        let parameters: Parameters = ["jsonrpc":"2.0","method":"\(API_METHOD.doExFrom)","params":ary,"id":randomInt()]
        
        Alamofire.request("\(API_URL)\(API_EXCURRENCY)", method: .post ,parameters:parameters ,  encoding: JSONEncoding.default , headers: ["Authorization": " Bearer \(user.get("Token"))"]).responseJSON{ response in
            
            guard let jr = JsonReturn.get(res: response) else {
                return
            }
            print(response)
            //檢查錯誤
            let err = jr.getErrorCode()
            if (err < 0){
                self.handleError(err)
                completion(false, nil)
                
                //處理失敗
                return
            }
            
            //檢查結果
            let res = jr.result!
                        
            completion(true, res)
            
        }
    }

    
  

}


