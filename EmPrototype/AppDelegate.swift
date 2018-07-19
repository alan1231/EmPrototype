//
//  AppDelegate.swift
//  EmPrototype
//
//  Created by alan on 2018/6/28.
//  Copyright © 2018年 alan. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        var navigation = UINavigationController(rootViewController:phoneNumberViewController())
        
//          user.remove("PinCode")
//          user.remove("PinStatus")
//          user.remove("Token")
//          user.remove("PinNumber")
        
//            user.save("PinNumber", "5")
//            user.save("PinStatus", "1")

        let defaults = UserDefaults.standard
        if  defaults.object(forKey: "Token") as? String == nil && defaults.object(forKey: "pinCode") == nil {
            navigation = UINavigationController(rootViewController:phoneNumberViewController())
        }else{
            navigation = UINavigationController(rootViewController:pinViewController())
            navigation.navigationBar.isHidden = true
        }
//        navigation = UINavigationController(rootViewController:pinViewController())
//        navigation.navigationBar.isHidden = true


        
        self.window = UIWindow(frame:UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        //1.创建导航控制器的根视图
        //2.创建导航视图控制器，并为他制定根视图控制器
        //3.将导航视图控制器设置为window的根视图控制器
        navigation.navigationBar.isHidden = true
        self.window?.rootViewController = navigation

        self.window?.backgroundColor = UIColor.white
        // Override point for customization after application launch.
        


        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

