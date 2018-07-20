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
    
//    var second = 20
//    var timer = Timer()
    
    var backgroundTask:UIBackgroundTaskIdentifier! = nil

    var navigation = UINavigationController(rootViewController:phoneNumberViewController())
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//          user.remove("PinCode")
//          user.remove("PinStatus")
//          user.remove("Token")
//          user.remove("PinNumber")
//          user.remove("PhoneNumber")
        
//            user.save("PinNumber", "5")
//            user.save("PinStatus", "1")

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
    
//    func runTimer(){
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//    }
//    @objc func  updateTimer(){
//        if second == 0{
//            timer.invalidate()
//            pin = true
//        }else{
//            second -= 1
//        }
//        print(second)
//    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if backgroundTask != nil{
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = UIBackgroundTaskInvalid
        }
        
            self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
                () -> Void in

//                self.second = 20
//                self.runTimer()
//                self.pin = false

            
                let vc = pinViewController()
                self.navigation.pushViewController(vc, animated: false)
                
                application.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = UIBackgroundTaskInvalid
            })
            
    
       application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
//        print("進")
//        if pin == false {
//
//            pin = true
//        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(5)
    }


}

