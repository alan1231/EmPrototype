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

public let viewSize = UIScreen.main.bounds.size

func RGBA (r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
