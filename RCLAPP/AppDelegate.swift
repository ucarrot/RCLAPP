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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
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
        
        //this helps to keep data when app offline , then syncronize with firebase when online.
        Database.database().isPersistenceEnabled = true
        
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
    
    //MARK: GoToApp
    
    func goToApp() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object:nil, userInfo: [kUSERID : FUser.currentId()])
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainChat") as! UITabBarController
        
        self.window?.rootViewController = mainView
    }

}

