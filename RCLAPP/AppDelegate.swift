//
//  AppDelegate.swift
//  RCLAPP
//
//  Created by Omar Al Romaithi on 8/15/18.
//  Copyright © 2018 UCarrot Software & Design. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authListener: AuthStateDidChangeListenerHandle? //auto login
    var firstLoad: Bool?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        //this helps to keep data when app offline , then syncronize with firebase when online.
        Database.database().isPersistenceEnabled = true
        
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.8443861604, green: 0.7837842107, blue: 0.6431472898, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        loadUserDefaults()
        //AutoLogin -------------------------------------------------------------
        authListener = Auth.auth().addStateDidChangeListener({(auth, user) in
            Auth.auth().removeStateDidChangeListener(self.authListener!)
            if user != nil {
                if UserDefaults.standard.object(forKey: kCURRENTUSER) != nil {
                    DispatchQueue.main.async {
                        self.goToApp()
                    }
                }
            }
        })
        //End of AutoLogin-------------------------------------------------------
        
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }
    
    func loadUserDefaults() {
        
        firstLoad = userDefaults.bool(forKey: kFIRSTRUN)
        
        if !firstLoad! {
            
            userDefaults.set(true, forKey: kFIRSTRUN)
            userDefaults.set("Dhs", forKey: kCURRENCY)
            userDefaults.synchronize()
        }
    }
    
    //MARK: GoToApp
    
    func goToApp() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object:nil, userInfo: [kUSERID : FUser.currentId()])
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcome") as! UITabBarController
        //"mainChat" have been replaced with "welcome" view
        
        mainView.selectedIndex = 0
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainView
        self.window?.makeKeyAndVisible()
    }

}

