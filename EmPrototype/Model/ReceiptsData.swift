//
//  ReceiptsData.swift
//  EmPrototype
//
//  Created by alan on 2018/9/10.
//  Copyright © 2018年 alan. All rights reserved.
//

import ObjectMapper

class ReceiptsData: Mappable {
    var list:[Receipts]?
    
    required init?(map:Map){
    }
    func mapping(map: Map) {
        list <- map["list"]
        
    }
    
}


class Receipts: Mappable {
    var txparams:TxParams?
    var txresult:TxResult?
    var id : String?
    var datetime : String?
    var datetime_ : Date?
    var currency : String?
    var message : String?
    var statusCode : Int?
    var statusMsg : String?
    var txType : Int?
    required init?(map:Map){
    }
    func mapping(map: Map) {
        txparams <- map["txParams"]
        txresult <- map["txResult"]
        id <- map["id"]
        datetime <- map["datetime"]
        currency <- map["currency"]
        message <- map["message"]
        statusCode <- map["statusCode"]
        statusMsg <- map["statusMsg"]
        txType <- map["txType"]
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        datetime_ = dateFormatter.date(from: datetime!)
    }
    
//    static func getTest(_ rec:Receipts)-> (a:String, String){
//        return ("a", b: "b")
//    }
//
    
//    static func getDispText(_ rec:Receipts)-> (name:String,a:String){
//
//        let toUserId = rec.txresult!.outflow!  ? rec.txparams?.receiver:rec.txparams?.sender
//        var str = ""
//
//        UserBank.get(userId: toUserId!){ user in
//
//            switch rec.txType {
//            case 1:
//                str = "存款"
//            case 2:
//                str = "提款"
//            case 3:
//                let paymode = rec.txresult!.outflow!  ? "付款":"收款"
//                var str = "-"
//                if let
//            case 4:
//                str = "換匯"
//            default:
//                break
//            }
//
//
//        }
//        return (str,"")
//
//    }
}

class TxParams: Mappable {
    var toCurrency : String?
    var sender : String?
    var receiver : String?
    var currency : String?
    var amount : Double?
    required init?(map:Map){
    }
    func mapping(map: Map) {
        toCurrency <- map["toCurrency"]
        sender <- map["sender"]
        receiver <- map["receiver"]
        currency <- map["currency"]
        amount <- map["amount"]
    }
}
class TxResult: Mappable {
    var outflow : Bool?
    var amount : Double?
    var balance : Double?
    required init?(map:Map){
    }
    func mapping(map: Map) {
        outflow <- map["outflow"]
        amount <- map["amount"]
        balance <- map["balance"]

    }
}
