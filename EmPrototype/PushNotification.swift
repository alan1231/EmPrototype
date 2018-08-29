//
//  PushNotification.swift
//  EmPrototype
//
//  Created by alan on 2018/8/13.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit


func userinfo ( _ userInfo:[AnyHashable : Any]){
    let info = userInfo as![String:AnyObject]
    print(info["aps"]!)
}
