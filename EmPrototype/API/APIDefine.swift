//
//  APIDefine.swift
//  EmPrototype
//
//  Created by alan on 2018/8/16.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

public let API_URL = "https://uwbackend-dev.azurewebsites.net/api/"
public let API_NUMBER = "https://uwfuncapp-dev.azurewebsites.net/api/"
public let API_UPPHOTO = "https://uwfuncapp-dev.azurewebsites.net/api/uploadAvatar"

//public let API_NUMBER = "https://uwfuncapp-rel.azurewebsites.net/api/"
//public let API_UPPHOTO = "https://uwfuncapp-rel.azurewebsites.net/api/uploadAvatar"
//public let API_URL = "https://uwbackend-rel.azurewebsites.net/api/"


public let API_AUTH = "auth"
public let API_NOTIFICATION = "notification"
public let API_CONTACT = "contacts"
public let API_PROFILE = "profile"
public let API_TRADING = "trading"
public let API_REQSMSVERITY = "reqSmsVerify"
public let API_EXCURRENCY = "excurrency"


enum API_METHOD  {
    case addFriends
    case broadcast
    case doExFrom
    case delFriends
    case estimateExFrom
    case findUsersByPhone
    case getContacts
    case getUsersProfile
    case getExRate
    case getAllUsers
    case getProfile
    case getBalances
    case getReceipts
    case reqSmsVerify
    case regPnsToken
    case login
    case sendMessage
    case updateProfile
    case transfer
    case isTokenAvailable

}
