//
//  Model.swift
//  EmPrototype
//
//  Created by alan on 2018/8/31.
//  Copyright © 2018年 alan. All rights reserved.
//

import ObjectMapper
class FriendData: Mappable {
    var list:[Contacts]?
    required init?(map:Map){
    }
    func mapping(map: Map) {
        list <- map["list"]
    }

}
class Contacts: Mappable {
    var avatar : String?
    var userId : String?
    var name : String?
    required init?(map:Map){
    }
    func mapping(map: Map) {
        avatar <- map["avatar"]
        userId <- map["userId"]
        name <- map["name"]
    }
}



