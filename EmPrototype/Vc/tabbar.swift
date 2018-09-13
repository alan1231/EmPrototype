//
//  tabbar.swift
//  EmPrototype
//
//  Created by alan on 2018/7/12.
//  Copyright © 2018年 alan. All rights reserved.
//

import UIKit

class tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let viewMain = homeViewController()
//        viewMain.title = "錢包"
//        let viewSetting = vc111()
//        viewSetting.title = "消息"
//        let a = AViewController()
//        a.title = "發現"
//        let b = BViewController()
//        b.title = "我"
        //分别声明两个视图控制器
//        let main = UINavigationController(rootViewController:viewMain)
//        main.tabBarItem.image = UIImage(named:"first")
        //定义tab按钮添加个badge小红点值
//        main.tabBarItem.badgeValue = "!"
        
//        let setting = UINavigationController(rootViewController:viewSetting)
//        setting.tabBarItem.image = UIImage(named:"second")
        
//        self.viewControllers = [main,setting,a,b]
        UITabBar.appearance().barTintColor = UIColor.white // your color
        //默认选中的是游戏主界面视图
        self.selectedIndex = 0
        
    }



}
