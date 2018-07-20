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
    
    var pin = true
    var second = Int()
    var timer = Timer()
    var backgroundTask:UIBackgroundTaskIdentifier! = nil
    var navigation = UINavigationController(rootViewController:phoneNumberViewController())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//          user.remove("PinCode")
//          user.remove("PinStatus")
//          user.remove("Token")
//          user.remove("PinNumber")
//          user.remove("PhoneNumber")
        


        let defaults = UserDefaults.standard
        if  defaults.object(forKey: "Token") as? String == nil && defaults.object(forKey: "pinCode") == nil {
            navigation = UINavigationController(rootViewController:phoneNumberViewController())
        }else{
            navigation = UINavigationController(rootViewController:pinViewController())
            navigation.navigationBar.isHidden = true
            pin = false
        }
//        navigation = UINavigationController(rootViewController:pinViewController())
//        navigation.navigationBar.isHidden = true


        
        self.window = UIWindow(frame:UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        navigation.navigationBar.isHidden = true
        self.window?.rootViewController = navigation
        self.window?.backgroundColor = UIColor.white
        // Override point for customization after application launch.
        


        
        return true
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func  updateTimer(){
        if second == 0{
            timer.invalidate()
            pin = true
        }else{
            second -= 1
        }
        print(second)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        if pin == false{
            self.second = 20
            self.runTimer()
        }

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if backgroundTask != nil{
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskInvalid
        }
        
            self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
                
                application.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = UIBackgroundTaskInvalid

            })
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        timer.invalidate()

        if pin == true {
            
            let vc = pinViewController()
            self.navigation.pushViewController(vc, animated: false)

            pin = false
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

