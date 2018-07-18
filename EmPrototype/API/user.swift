//
//  user.swift
//  EmPrototype
//
//  Created by alan on 2018/7/18.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class user: NSObject {
    static func save (_ key:String, _ value:String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    static func get (_ key:String)->String{
        let defaults = UserDefaults.standard
        return defaults.object(forKey:key) as! String
    }
    static func remove (_ key:String){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        print(defaults.object(forKey:key) as? String as Any)
    }
}
