//
//  user.swift
//  EmPrototype
//
//  Created by alan on 2018/7/18.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit
public enum userDefine :String {
    case PinCode
    case PinStatus
    case Token
    case PinNumber
    case PhoneNumber
    case DeviceToken
    case username
}



class user: NSObject {
    static func save (_ key:String, _ value:String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    static func get (_ key:String)->String{
        let defaults = UserDefaults.standard
        let str = defaults.object(forKey:key)
        return str as! String
    }
    static func remove (_ key:String){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        print(defaults.object(forKey:key) as? String as Any)
    }
}
