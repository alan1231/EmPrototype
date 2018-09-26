//
//  Define.swift
//  EmPrototype
//
//  Created by alan on 2018/7/10.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

public let width = UIScreen.main.bounds.size.width//获取屏幕宽
public let height = UIScreen.main.bounds.size.height//获取屏幕高

public let mobiColor = UIColor(red: 37/255.0, green: 66/255.0, blue: 152/255.0, alpha: 1)
public let systemBuleColor = UIColor(red: 25/255.0, green: 56/255.0, blue: 145/255.0, alpha: 1)
public let cgGray = UIColor(red: 193/255, green: 191/255, blue: 194/255, alpha: 1)
public let cgBlackGray = UIColor(red: 149/255, green: 149/255, blue: 152/255, alpha: 1)
public let tabcellGray = UIColor(red: 232/255, green: 229/255, blue: 226/255, alpha: 1)

public let viewSize = UIScreen.main.bounds.size
public let loadviewBG = UIView()


public var CurrencyName = [String]()
public var CurrencyBalance = [String]()
public let CurrencySign = ["CNY":"¥","USD":"$","BTC":"₿","ETH":"Ξ"]
public let CurrencyiCon = ["CNY":"cnycoin","USD":"usdcoin","BTC":"btccoin","ETH":"ethcoin"]

public var PinBool = true


func RGBA (r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func getNowTime()->Int{
    let now:Date = Date()
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    let time:Int = Int(timeInterval)
    return time
}

func getSizeFromString(string:String, withFont font:UIFont)->CGSize{
    
    let textSize = NSString(string: string ).size(
        
        withAttributes: [ NSAttributedString.Key.font:font ])
    
    return textSize
    
}
func randomInt() -> Int{
    let int = Int(arc4random_uniform(9999)+1)
    return int
}
func localizedStr (_ string:String) -> String{
        return  NSLocalizedString(string, comment: "")
}
 func setupView(_ view:UIView) {
    
    loadviewBG.frame = view.frame
    loadviewBG.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    view.addSubview(loadviewBG)
    
    
    let lview = UIView()
    lview.backgroundColor = UIColor.white
    lview.frame = CGRect(x: view.frame.midX-40, y: view.frame.midY-40, width: 80, height: 80)
    lview.layer.cornerRadius = lview.frame.size.width/2
    loadviewBG.addSubview(lview)
    
    let loadingView = LoadingView(frame: CGRect(x: lview.frame.width/2 - 30, y: lview.frame.height/2 - 30, width: 60, height: 60))
    
    loadingView.startLoading()
    lview.addSubview(loadingView)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+30) {
        
        loadviewBG.removeFromSuperview()
        
    }
}

func stoploadingView(){
    loadviewBG.removeFromSuperview()
}

