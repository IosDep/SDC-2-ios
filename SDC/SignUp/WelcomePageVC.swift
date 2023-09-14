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
import JGProgressHUD
import MOLH

class WelcomePageVC: UIViewController {
    
    @IBOutlet weak var mainTitle: DesignableLabel!
    @IBOutlet weak var SignUpButton:UIButton!
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    
    var urls : [URL] = []
    var imageSources: [SDWebImageSource] = []
    static var homeImage : String?
    static var loginImage : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.SignUpButton.layer.borderColor = UIColor.init(rgb: 0x4CC18B).cgColor
        if MOLHLanguage.isRTLLanguage() {
            mainTitle.font = UIFont(name: "Poppins-Medium", size: 17.0)

        }
        

        self.SignUpButton.layer.borderWidth = 1
        self.configureSlideShow()
        self.getMobileLayouts()

    }
    
  
    
    @IBAction func englishPressed(_ sender: Any) {
        
        MOLH.setLanguageTo("en")
        MOLH.reset()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.reset()
    }
    
    
    @IBAction func arabicPressed(_ sender: Any) {
        
        MOLH.setLanguageTo("ar")
        MOLH.reset()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.reset()
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
                if let user = ApplicationData.shared.getAccountsList()?.first {
                    self?.LoginRequest(username: user.userName, password: user.password)
                }
//                self?.gooingToHome()
                        } else {
                            let ac = UIAlertController(title: "Authenticationfailed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                            ac.addAction (UIAlertAction(title: "OK".localized(), style: .default))
                            self?.present(ac, animated: true)
    
                        }
                    }
                }
            }else{
                let ac = UIAlertController(title: "Biometry unavailable", message:
                                            "Your device is not configured for biometric authentication.".localized(),
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
        

        
    }
    
    func gooingToHome(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.isLogin()
    }
    
    func configureSlideShow() {
        
        slideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .under)
        slideShow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)

        slideShow.setImageInputs(AppDelegate.imageSources)
        
        slideShow.slideshowInterval = 2
        
    }
    
    // Helper.shared.getBiometricUsername() ?? ""
    
    func LoginRequest(username: String, password: String) {

        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let endpoint = URL(string:APIConfig.Login)
        let param: [String: String] = [
            "username": username,
            "password": password,
            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en",
            "login_type": "1"
          
        ]
        
        AF.request(endpoint!, method: .post, parameters: param).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        //    object status
                        
                            if let status = jsonObj!["status"] as? Bool {
                                
                               
                                if status == true {
                                    
                                   
                                     let message = jsonObj!["errNum1"] as? String
                                    
                                    let user_data = jsonObj!["user_data"] as? [String:Any]
                                    
    
                                    
                                    Helper.shared.saveToken(auth: user_data!["access_token"] as? String ?? "")
                                    Helper.shared.SaveSeassionId(seassionId: user_data!["sessionId"] as? String ?? "")
                                    Helper.shared.saveUserId(id:  user_data!["user_id"] as? Int ?? 1)

                                    
//                                    showing Done Flag
//                                    self.showSuccessHud(msg:                                         message ?? "", hud: hud)
//
                                    DispatchQueue.main.async {
                                        hud.dismiss(afterDelay: 1.5, animated: true,completion: {
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            appDelegate.isLogin()
                                        })
                                        
                                        
                                    }
                                    
                                }
                                
                                //    status ==> false
                                else {
                                    
                                    if let message = jsonObj!["message"] as? String {
                                        hud.dismiss()
                                        self.showErrorHud(msg: message)
                                           
                                        }
                                        
                                    }
                                
                            }
                        
                    }
                    
                } catch let err as NSError {
                    print("Error: \(err)")
                    self.serverError(hud: hud)
                    //                        self.refreshControl?.endRefreshing()
                }
            } else {
                print("Error")
                self.internetError(hud: hud)
                //                    self.refreshControl?.endRefreshing()
            }
        }
    }
 
    
    
    
    func getMobileLayouts(){
        
        
        let link = URL(string: APIConfig.GetMobileLayouts)
        
        
        AF.request(link!, method: .post , parameters: [:] , headers: nil ).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    
                    if jsonObj != nil {
                        
                        if let status = jsonObj!["status"] as? Int {
                            if status == 200 {
                                
                                
                                if  let data  = jsonObj!["data"] as? [String : Any] {
                                  
                                    let id  = data["id"] as? Int
                                    
                                    let login_image  = data["login_image"] as? String
                                    
                                    if let home_image = data["home_image"] as? String {
                                        
                                        WelcomePageVC.homeImage = home_image
                                        
                                        WelcomePageVC.loginImage = login_image

                                    }
                                    
                                    
//                                    DispatchQueue.main.async {
//
//                                        self.loginImage.sd_setImage(with: URL(string: login_image ?? ""))
//
//
//                                    }
                                    
                                  
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
