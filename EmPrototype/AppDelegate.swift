//
//  AppDelegate.swift
//  EmPrototype
//
//  Created by alan on 2018/6/28.
//  Copyright © 2018年 alan. All rights reserved.
//
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var backgroundTask:UIBackgroundTaskIdentifier! = nil
    var navigation = UINavigationController(rootViewController:phoneNumberViewController())
    var goinTime = Int()
    var pin = true
    let center = UNUserNotificationCenter.current()
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
//        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
//        center.getNotificationSettings { ( settings ) in
//            switch settings.authorizationStatus {
//            case .notDetermined:
//                self.center.requestAuthorization(options: options) {
//                    (granted, error) in
//                    if !granted {
//                        print("Something went wrong")
//                    }
//                }
//            case .authorized:
//                DispatchQueue.main.async(execute: {
//                    UIApplication.shared.registerForRemoteNotifications()
//                })
//            case .denied:
//                print("cannot use notifications cuz the user has denied permissions")
//            }
//        }

        
        
        //要求用戶同意推播通知訊息的協定
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                (accepted, error) in
                if !accepted {
                    print("用户不允许消息通知。")
                }
        }
        //device 裝置的 token
        UIApplication.shared.registerForRemoteNotifications()

        
        
//        user.remove(userDefine.PinCode.rawValue)
//        user.remove(userDefine.DeviceToken.rawValue)
//        user.remove(userDefine.Token.rawValue)
//        user.remove(userDefine.PhoneNumber.rawValue)
//        user.remove(userDefine.PinStatus.rawValue)
//        user.remove(userDefine.PinNumber.rawValue)
        

        

        //進入app 判斷 裝置token&pinCode 有無 儲存, 是不是第一次 使用app , 是的話 進入 註冊畫面 不是的話進入 pincode 解鎖畫面
        let defaults = UserDefaults.standard
        if  defaults.object(forKey: "Token") as? String != nil && defaults.object(forKey: "PinCode") != nil && defaults.object(forKey: "Name") as? String != nil {
            
            self.navigation = UINavigationController(rootViewController:pinViewController())
            self.navigation.navigationBar.isHidden = true
            self.pin = false
                    
            
            
            
                    APIManager.getApi.cheackToken(completion: {
                        result in
            
                        let cheack = result!["result"] as! Bool
            
                        if (cheack){
                            print("t")
                            self.navigation = UINavigationController(rootViewController:pinViewController())
                            self.navigation.navigationBar.isHidden = true
                            self.pin = false
                        }else{
                            print("f")
                            
                            
                            let alertController = UIAlertController(
                                title: "重複登入",
                                message: "",
                                preferredStyle: .alert)
                            
                            let clear = UIAlertAction(title: "確定", style: .destructive, handler: {
                                (action:UIAlertAction)
                                -> Void in
                                user.remove("PinCode")
                                user.remove("PinStatus")
                                user.remove("Token")
                                user.remove("PinNumber")
                                user.remove("PhoneNumber")
                                user.remove("Name")
                                let vc = phoneNumberViewController()
                                self.navigation.pushViewController(vc, animated: false)
                                self.navigation.navigationBar.isHidden = true
                                
                            })
                            alertController.addAction(clear)
                            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
                        }
            
                    })
            
            
            }else{
            navigation = UINavigationController(rootViewController:phoneNumberViewController())

        }
        
        DispatchQueue.main.async{
            //以下 使用 導引列 UINavigationController
            self.window = UIWindow(frame:UIScreen.main.bounds)
            self.window?.makeKeyAndVisible()
            self.navigation.navigationBar.isHidden = true
            self.window?.rootViewController = self.navigation
            self.window?.backgroundColor = UIColor.white
        }
      return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var deviceTokenString = ""
        
        
        //print device token
        for byte in deviceToken {
            let hexString = String(format: "%02x", byte)
            deviceTokenString = deviceTokenString + hexString
        }
        
        print("DeviceToken: \(String(describing: deviceTokenString))")
        let token = String(deviceTokenString)
        user.save(userDefine.DeviceToken.rawValue, "\(token)")
        
    }
    

    
    func applicationWillResignActive(_ application: UIApplication) {
        goinTime = getNowTime()
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        print(userInfo as! [String:AnyObject])
        
        let user = userInfo["aps"] as! [String:AnyObject]
        
        
        if userInfo["custom"] != nil{
            let custom = userInfo["custom"] as! [String:AnyObject]
            if let type = custom["type"]{
                if (type as! String) == "LOGOUT" {
                    let alert = UIAlertController(title: "Your have message", message: "\(user["alert"] as! String)", preferredStyle: .alert)
                    
                    let cancelButton = UIAlertAction(title: "確定", style: .cancel, handler: {
                        (action:UIAlertAction)
                        -> Void in
                        self.cleandata()
                        
                    })
                    
                    alert.addAction(cancelButton)
                    
                    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        



        
//        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
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
        let defaults = UserDefaults.standard
        if  defaults.object(forKey: "Token") as? String == nil && defaults.object(forKey: "pinCode") == nil {
            
        }else{
            cheacktoken()
        }
    }
    func cheacktoken(){
        APIManager.getApi.cheackToken(completion: {
            result in
            
            let cheack = result!["result"] as! Bool
            
            if (cheack){
                print("t")
                if getNowTime() - self.goinTime >= 20{
                    let vc = pinViewController()
                    self.navigation.pushViewController(vc, animated: false)
                    self.navigation.navigationBar.isHidden = true
                    print(self.navigation.viewControllers)
                }
            }else{
                print("f")
                
                let alertController = UIAlertController(
                    title: "重複登入",
                    message: "",
                    preferredStyle: .alert)
                
                let clear = UIAlertAction(title: "確定", style: .default, handler: {
                    (action:UIAlertAction)
                    -> Void in
                    self.cleandata()
                })
                alertController.addAction(clear)
                UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
            }
            
        })
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func cleandata(){
        user.remove("PinCode")
        user.remove("PinStatus")
        user.remove("Token")
        user.remove("PinNumber")
        user.remove("PhoneNumber")
        user.remove("Name")
        let vc = phoneNumberViewController()
        self.navigation.pushViewController(vc, animated: false)
        self.navigation.navigationBar.isHidden = true
    }

}

