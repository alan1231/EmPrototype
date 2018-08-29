//
//  APIDefine.swift
//  EmPrototype
//
//  Created by alan on 2018/8/16.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

//public let API_URL = "https://uwbackend-demo.azurewebsites.net/api/"
public let API_URL = "https://uwbackend-asia.azurewebsites.net/api/"

public let API_AUTH = "auth"
public let API_NOTIFICATION = "notification"
public let API_CONTACT = "contacts"
public let API_PROFILE = "profile"
public let API_TRADING = "trading"
enum API_METHOD  {
    case regPnsToken
    case getAllUsers
    case login
    case sendMessage
    case broadcast
    case updateProfile
    case getUsersProfile
    case getProfile
    case getBalances
    case transfer
    case isTokenAvailable
}
