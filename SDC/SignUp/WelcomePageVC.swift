//
//  WelcomePageVC.swift
//  SDC
//
//  Created by Blue Ray on 14/03/2023.
//

import UIKit
import LocalAuthentication

class WelcomePageVC: UIViewController {
    @IBOutlet weak var SignUpButton:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.SignUpButton.layer.borderColor = UIColor.init(rgb: 0x4CC18B).cgColor
        self.SignUpButton.layer.borderWidth = 1
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
                        //                        self?.unlockSecretMessage()
                        
                        
                        self?.gooingToHome()
                    } else {
                        let ac = UIAlertController(title: "Authenticationfailed", message: "You could not be verified; pleasetry again.", preferredStyle: .alert)
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
    func gooingToHome(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.isLogin()
    }
    
}
