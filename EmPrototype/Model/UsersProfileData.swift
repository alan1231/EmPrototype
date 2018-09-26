//
//  UsersProfileData.swift
//  EmPrototype
//
//  Created by alan on 2018/9/19.
//  Copyright © 2018年 alan. All rights reserved.
//

import ObjectMapper
class UsersProfileData: Mappable {
    var list:[UserProfile]?
    required init?(map:Map){
    }
    func mapping(map: Map) {
        list <- map["list"]
    }
    

}

class UserProfile: Mappable {
    var name : String?
    var userId : String?
    var avatar : String?
    required init?(map:Map){
    }
    func mapping(map: Map) {
        name <- map["name"]
        userId <- map["userId"]
        avatar <- map["avatar"]
    }
}
