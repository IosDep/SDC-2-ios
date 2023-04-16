//
//  AppDelegate.swift
//  SDC
//
//  Created by Blue Ray on 28/12/2022.
//

import UIKit
import MOLH
import netfox
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate ,MOLHResetable{
    func reset() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "tabNav")
        self.window?.rootViewController = vc
    }
    
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupLogging()
        self.setUpNetworkInterceptor()
        MOLHLanguage.setDefaultLanguage("en")
        MOLH.shared.activate(false)
        
// check user Login
//
//        if Helper.shared.getUserId() == 0 {
//
//            self.notLogin()
//
//        }else {
//            self.isLogin()
//
//        }
//
        return true
    }
    func isLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "tabNav")
        self.window?.rootViewController = vc
    }
    
    func notLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC")
        self.window?.rootViewController = vc
    }
    
}
extension AppDelegate {
    func setupLogging() {
#if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
#endif
    }
    private func setUpNetworkInterceptor() {
        
            NFX.sharedInstance().start()
        
    }
}
