
//  pinCollectionViewCell.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class pinCollectionViewCell: UICollectionViewCell {
    var titleLabel:UILabel?//title
    var titleLabelbackground = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implementeds")
    }
    
    //數字鍵
    func initView(){
        
        titleLabel = UILabel(frame:CGRect(x: 0, y: 12, width: width/3.18, height: width/12))
        titleLabel?.textColor = UIColor.black
        titleLabel?.font = UIFont.systemFont(ofSize: 28)
        titleLabel?.textAlignment = .center
        
        titleLabelbackground.center = (titleLabel?.center)!
        
        titleLabelbackground = UILabel(frame: CGRect(x:  (titleLabel?.frame.size.width)!/3.88, y:(titleLabel?.frame.size.height)!/19, width: width/6.5, height: width/6.5))
        
        titleLabelbackground.layer.cornerRadius = titleLabelbackground.frame.size.width/2
        titleLabelbackground.backgroundColor = UIColor.white
        titleLabelbackground.layer.masksToBounds=true
        
        self.addSubview(titleLabelbackground)
        
        self .addSubview(titleLabel!)
        
        
        
    }
    
}
