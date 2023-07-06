//
//  WelcomePageVC.swift
//  SDC
//
//  Created by Blue Ray on 14/03/2023.
//

import UIKit
import LocalAuthentication
import ImageSlideshow

class WelcomePageVC: UIViewController {
    @IBOutlet weak var SignUpButton:UIButton!
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.SignUpButton.layer.borderColor = UIColor.init(rgb: 0x4CC18B).cgColor
        self.SignUpButton.layer.borderWidth = 1
        self.configureSlideShow()
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
                            ac.addAction (UIAlertAction(title: "OK", style: .default))
                            self?.present(ac, animated: true)
    
                        }
                    }
                }
            }else{
                let ac = UIAlertController(title: "Biometry unavailable", message:
                                            "Your device is not configured for biometric authentication.",
                                           preferredStyle: .alert)
                ac.addAction (UIAlertAction(title: "OK", style: .default))
                present (ac, animated: true)
            }

            
        }
        
        else {
            let ac = UIAlertController(title: "Biometry unavailable", message:
                                        "Your device is not configured for biometric authentication.",
                                       preferredStyle: .alert)
            ac.addAction (UIAlertAction(title: "OK", style: .default))
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
        slideShow.setImageInputs([
            ImageSource(image: UIImage(named: "homebckground1")!),
            ImageSource(image: UIImage(named: "homebckground1")!),ImageSource(image: UIImage(named: "homebckground1")!),
            ImageSource(image: UIImage(named: "homebckground1")!)
          
        ])
        slideShow.slideshowInterval = 2
        
    }
    
}
