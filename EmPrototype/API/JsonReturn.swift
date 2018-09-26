//
//  JsonReturn.swift
//  EmPrototype
//
//  Created by alan on 2018/9/5.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
import Alamofire

class JsonReturn {
    
    var result: [String:AnyObject]?
    var error: [String:AnyObject]?
//    var error: Any = NSNull
//
//    init(res : DataResponse<Any>){
//        let data = res.result.value as? [String:AnyObject]
//        if (data != nil){
//            result = data!["result"] as? [String:AnyObject]
//            error = data!["error"] as? [String:AnyObject]
//        }
//
//    }
    init(){
        
    }
    
    static func get(res :DataResponse<Any>) -> JsonReturn?{
        let data = res.result.value as? [String:AnyObject]
        if (data != nil){
            let jr = JsonReturn()
            jr.result = data!["result"] as? [String:AnyObject]
            jr.error = data!["error"] as? [String:AnyObject]
            return jr
        }
        return nil
    }
    
    
    
    func getErrorCode() -> Int{
        if let error = error{
            return error["code"] as! Int
        }
        return 0
    }
//    func getErrorMessage() -> String{
//        switch getErrorCode() {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
    
}

import ObjectMapper

class UserBank {
    static var dict = [String: UserProfile?]()
    
    static func get(userId: String, callback: @escaping (UserProfile?)->Void) -> Void{
        
        let found = dict[userId]
        
        if found != nil {
//            var u = UserProfile(JSON: [String : Any]())
//            u?.name = "jim"
//            callback(u)
            callback(found!)
        }
        else{
            
            //api
            APIManager.getApi.getUsersProfile([userId]) { (err, user) in
//                print(user?.list)
//                user?.list![0]
                callback(user?.list![0])
                dict[userId] = user?.list![0]
            }
            
            
        }

    }
}
