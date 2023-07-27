//
//  AccountVC.swift
//  SDC
//
//  Created by Blue Ray on 19/03/2023.
//

import UIKit
import MOLH
import LocalAuthentication

class AccountVC: UIViewController {
    

    
    @IBOutlet weak var biometricSwitch: UISwitch!
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }
    
    
   
    @IBAction func biometricSwitchPressed(_ sender: UISwitch) {
        
        if sender.isOn {
            enableBiometricAuthentication()
        }
        else if sender.isOn == false {
               disableBiometricAuthentication()
           }
    }
    
    @IBOutlet weak var scroll: UIScrollView!
    
    enum Actions: Int {
        case CHANGEPASSWROD = 0
        case CHANGELANG = 1
        case USERGUIDE = 2
        case Concept = 3
        case TERMSANDCONDETION = 4
        case NOTICE = 5
        case FINGERPOINT = 6
        case LOGOUT = 7

    }
//    @IBOutlet weak var bellview: UIView!
    
    
    @IBOutlet weak var scrollViewHolder: UIView!
    
    
    @IBOutlet weak var arrowImag1: UIImageView!
    @IBOutlet weak var arrowImag2: UIImageView!
    @IBOutlet weak var arrowImag3: UIImageView!
    @IBOutlet weak var arrowImag4: UIImageView!
    @IBOutlet weak var arrowImag5: UIImageView!
    @IBOutlet weak var arrowImag6: UIImageView!
    @IBOutlet weak var arrowImag7: UIImageView!
    @IBOutlet weak var arrowImag8: UIImageView!
    
    
    
    var imageViewWithCount: UIView!
    var countLabel: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkBiometric()
        self.navigationText(title: "Account Settings".localized())
        
        
        

    }
    
    override func viewDidLayoutSubviews() {
        scroll.roundCorners([.topLeft, .topRight], radius: 20)
    }


//    Action
    @IBAction func Aaction(btn:UIButton){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)

        if btn.tag == Actions.CHANGEPASSWROD.rawValue {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPassword") as! ForgetPassword
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true)
            
            
        }
        else  if btn.tag == Actions.CHANGELANG.rawValue {
            
            let vc = storyBoard.instantiateViewController(withIdentifier: "ChangeLanguage") as! ChangeLanguage
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        }
        
        else  if btn.tag == Actions.USERGUIDE.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "WebVcContent") as! WebVcContent
            vc.flag = 0
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
            
        }
        
        else  if btn.tag == Actions.Concept.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "WebVcContent") as! WebVcContent
            vc.flag = 1
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
        
        
        else  if btn.tag == Actions.TERMSANDCONDETION.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "WebVcContent") as! WebVcContent
            vc.flag = 2
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
     
        else  if btn.tag == Actions.NOTICE.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "WebVcContent") as! WebVcContent
            vc.flag = 3
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
    
        }
        

        
        
        else  if btn.tag == Actions.LOGOUT.rawValue {
            let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC") as! WelcomePageVC
            vc.modalPresentationStyle = .fullScreen
      
            self.present(vc, animated: true)
            
        }
        
        
        
    }
    
    
    func enableBiometricAuthentication() {

        
//        Helper.shared.saveBiometricUsername(username: LoginVC.username ?? "")
//
//        Helper.shared.saveBiometricPass(pass: LoginVC.pass ?? "")
//
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
                    
                UserDefaults.standard.set(true, forKey: "biometricAuthenticationEnabled")
                    ApplicationData.shared.setAccount(with: Account(userName: LoginVC.username ?? "", password: LoginVC.pass ?? ""))
                                
                            } else {
                                DispatchQueue.main.async {
                                    
                                    self?.biometricSwitch.setOn(false, animated: true)
                                }
        
                            }
                        }
                    }
                }else{
                    
                    if let error = error {
                               print("Biometric authentication not available: \(error.localizedDescription)")
                           }
                }
    }
    
    func disableBiometricAuthentication() {
        if let user = ApplicationData.shared.getAccountsList()?.first {
            ApplicationData.shared.removeAccount(user)
//            ApplicationData.shared.updateAccount(with: Account(userName: user.userName, password: ""))
        }
        UserDefaults.standard.removeObject(forKey: "biometricAuthenticationEnabled")
    }




    func checkBiometric() {
        
        // enrolled ?
        
        if UserDefaults.standard.bool(forKey: "biometricAuthenticationEnabled") == true {
            biometricSwitch.setOn(true, animated: true)
        }
        
        else   {
            biometricSwitch.setOn(false, animated: true)
        }
    }
    

}



