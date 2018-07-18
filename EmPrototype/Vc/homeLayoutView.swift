//
//  homeLayoutView.swift
//  EmPrototype
//
//  Created by alan on 2018/7/16.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class homeLayoutView: UIView {
    let setGetview = UIView()
    let getBtn = UIButton()
    let sedBtn = UIButton()
    let CryptoBtn = UIButton()
    let FiatBtn = UIButton()
    let pageview = UIScrollView()
    
    
    init(frame: CGRect,VC:homeViewController) {
        super.init(frame:frame)
        setGetview.frame = CGRect(x: 0, y: viewSize.height/3.5 , width: viewSize.width, height: viewSize.height/10)
        setGetview.backgroundColor = UIColor(red: 22/255, green: 45/255, blue: 113/255, alpha: 1)
        self.addSubview(setGetview)
        
        sedBtn.frame = CGRect(x: 0, y: 0, width: setGetview.frame.width/2, height: setGetview.frame.height)
        sedBtn.setImage(UIImage(named:"sendBtn"), for: .normal)
        setGetview.addSubview(sedBtn)
        
        getBtn.frame = CGRect(x: setGetview.frame.width/2, y: 0, width: setGetview.frame.width/2, height: setGetview.frame.height)
        getBtn.setImage(UIImage(named: "getBtn"), for: .normal)
        setGetview.addSubview(getBtn)
        
        let line = UIView ()
        line.frame = CGRect(x: (setGetview.frame.width/2)-0.5 , y: 10, width: 1, height: setGetview.frame.height-20)
        line.backgroundColor = UIColor.gray
        setGetview.addSubview(line)
        
        let view2 = UIView()
        view2.frame  = CGRect(x: 0, y: setGetview.frame.origin.y + setGetview.frame.size.height, width: setGetview.frame.size.width, height: viewSize.height/12)
        view2.backgroundColor = UIColor.white
        self.addSubview(view2)
        
        CryptoBtn.setTitle("數字貨幣", for: .normal)
        CryptoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 18))
        CryptoBtn.setTitleColor(UIColor.black, for: .normal)
        CryptoBtn.frame = CGRect(x: 10, y: 0, width: viewSize.width/4.8, height: view2.frame.height)
        view2.addSubview(CryptoBtn)
        
        FiatBtn.setTitle("法幣", for: .normal)
        FiatBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 18))
        FiatBtn.setTitleColor(UIColor.gray, for: .normal)
        FiatBtn.frame = CGRect(x: CryptoBtn.frame.origin.x + CryptoBtn.frame.width + 20, y: 0, width: viewSize.width/6, height: view2.frame.height)
        view2.addSubview(FiatBtn)
        
        
        pageview.frame = CGRect(x: 0, y: view2.frame.origin.y + view2.frame.size.height, width: viewSize.width, height: viewSize.height/2.15)
        pageview.backgroundColor = UIColor.red
        pageview.contentSize = CGSize(width: viewSize.width*2, height: viewSize.height/3)
        pageview.showsVerticalScrollIndicator = false
        pageview.bouncesZoom = false
        pageview.showsHorizontalScrollIndicator = false
        pageview.isPagingEnabled = true


        self.addSubview(pageview)
        
        let v1 = UIView()
        v1.backgroundColor = UIColor.groupTableViewBackground
        v1.frame = CGRect(x: pageview.frame.origin.x, y: 0, width: pageview.frame.size.width, height: pageview.frame.size.height)
        pageview.addSubview(v1)
        
        let v2 = UIView()
        v2.backgroundColor = UIColor.yellow
        v2.frame = CGRect(x: pageview.frame.origin.x + pageview.frame.size.width , y: 0, width: pageview.frame.size.width, height: pageview.frame.size.height)
        pageview.addSubview(v2)

        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
