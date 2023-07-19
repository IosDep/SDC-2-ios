//
//  WelcomePageVC.swift
//  SDC
//
//  Created by Blue Ray on 14/03/2023.
//

import UIKit
import LocalAuthentication
import ImageSlideshow
import Alamofire
import SDWebImage

class WelcomePageVC: UIViewController {
    @IBOutlet weak var SignUpButton:UIButton!
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    var urls : [URL] = []
    var imageSources: [SDWebImageSource] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.SignUpButton.layer.borderColor = UIColor.init(rgb: 0x4CC18B).cgColor
        self.SignUpButton.layer.borderWidth = 1
        self.getSliderImages()
    }
    
    @IBAction func signIn(_ sender:UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
  
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func signUp(_ sender:UIButton){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "IdentfairVC") as! IdentfairVC
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    @IBAction func fingerPoint(_ sender:UIButton){
        
        
        if UserDefaults.standard.bool(forKey: "biometricAuthenticationEnabled") == true {
            
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy (.deviceOwnerAuthenticationWithBiometrics,
                                          error: &error) {
                let reason = "Identify yourself!"
                context.evaluatePolicy (.deviceOwnerAuthenticationWithBiometrics,
                                        localizedReason: reason) { [weak self] success,
                    authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            print("DONEEE")
                            self?.gooingToHome()
                        } else {
                            let ac = UIAlertController(title: "Authenticationfailed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                            ac.addAction (UIAlertAction(title: "OK".localized(), style: .default))
                            self?.present(ac, animated: true)
    
                        }
                    }
                }
            }else{
                let ac = UIAlertController(title: "Biometry unavailable", message:
                                            "Your device is not configured for biometric authentication.",
                                           preferredStyle: .alert)
                ac.addAction (UIAlertAction(title: "OK".localized(), style: .default))
                present (ac, animated: true)
            }

            
        }
        
        else {
            let ac = UIAlertController(title: "Biometry unavailable".localized(), message:
                                        "Your device is not configured for biometric authentication.".localized(),
                                       preferredStyle: .alert)
            ac.addAction (UIAlertAction(title: "OK".localized()
                                        , style: .default))
            present (ac, animated: true)
        }
        
        
                    
        
//        if isFaceIDEnabled {
//                authenticateWithFaceID()
//            } else {
//
//            }
        
//        let context = LAContext()
//        var error: NSError?
//        if context.canEvaluatePolicy (.deviceOwnerAuthenticationWithBiometrics,
//                                      error: &error) {
//            let reason = "Identify yourself!"
//            context.evaluatePolicy (.deviceOwnerAuthenticationWithBiometrics,
//                                    localizedReason: reason) { [weak self] success,
//                authenticationError in
//                DispatchQueue.main.async {
//                    if success {
//                        print("DONEEE")
                        //                        self?.unlockSecretMessage()
//                        self?.gooingToHome()
//                    } else {
//                        let ac = UIAlertController(title: "Authenticationfailed", message: "You could not be verified; please try again.", preferredStyle: .alert)
//                        ac.addAction (UIAlertAction(title: "OK", style: .default))
//                        self?.present(ac, animated: true)
//
//                    }
//                }
//            }
//        }else{
//            let ac = UIAlertController(title: "Biometry unavailable", message:
//                                        "Your device is not configured for biometric authentication.",
//                                       preferredStyle: .alert)
//            ac.addAction (UIAlertAction(title: "OK", style: .default))
//            present (ac, animated: true)
//        }
        
    }
    
    func gooingToHome(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.isLogin()
    }
    
    func configureSlideShow() {
        
        slideShow.setImageInputs(imageSources)
        
        slideShow.slideshowInterval = 2
        
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
                                      self.imageSources.append(SDWebImageSource(url: urlstring))
                                  }
                                    
                                }
                                
                                DispatchQueue.main.async {
                                    self.configureSlideShow()
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
    
    
    
    
    
}
