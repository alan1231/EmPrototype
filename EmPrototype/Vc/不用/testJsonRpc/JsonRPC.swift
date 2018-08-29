//
//  JsonRPC.swift
//  EmPrototype
//
//  Created by alan on 2018/8/8.
//  Copyright © 2018年 alan. All rights reserved.
//

import Foundation
class JSONRPC {
    
    class func post (params : NSDictionary, url : String, postCompleted : @escaping (_ succeeded: Bool, _ msg: String, _ data:String) -> ()) {
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch (let e) {
            print(e)
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? NSDictionary
            
            guard json != nil else {
                
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Error could not parse JSON: \(String(describing: jsonStr))")
                postCompleted(false,(response?.description)!,"Error")

                return
            }
            postCompleted(true,(response?.description)!,NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String)
        }).resume()
    }
    
    
}
