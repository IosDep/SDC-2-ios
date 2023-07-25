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
import Alamofire
import SDWebImage
import ImageSlideshow

@main
class AppDelegate: UIResponder, UIApplicationDelegate ,MOLHResetable{
    
    func reset() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "tabNav")
        self.window?.rootViewController = vc
    }
    
    
    
    var window: UIWindow?
    static var imageSources: [SDWebImageSource] = []
    var urls : [URL] = []
    let delayInSeconds: TimeInterval = 3.0

    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupLogging()
        self.setUpNetworkInterceptor()
        MOLHLanguage.setDefaultLanguage("en")
        MOLH.shared.activate(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC") as! WelcomePageVC
            
            self.window?.rootViewController = vc
        }
            
        
        self.getSliderImages()
        
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
    
    func getSliderImages(){
        
        
        let link = URL(string: APIConfig.GetSliderImages)
        
        
        AF.request(link!, method: .post , parameters: [:] , headers: nil ).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                
                                if  let data  = jsonObj!["data"] as? [String] {
                                    
                                    for i in data {
                                        self.urls.append((URL(string: i) ?? URL(string: ""))!)
                                        
                                    }
                                    
                                    for urlstring in self.urls {
                                        AppDelegate.imageSources.append(SDWebImageSource(url: urlstring))
                                    }
                                    
                                }
                                
                                DispatchQueue.main.async {
                                    
                                    //                                    self.configureSlideShow()
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                    }
                    
                    else {
                        print("erorrr")
                    }
                    
                } catch let err as NSError {
                    print("Error: \(err)")
                    
                    
                }
            } else {
                print("Error")
                
                
            }
        }
        
    }
    
    func LaunchingRootView() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC") as! WelcomePageVC
        self.window?.rootViewController = vc
    }
    
    func FetchingData() {

        
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
