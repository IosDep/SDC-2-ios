//
//  LogiinVC.swift
//  SDC
//
//  Created by Blue Ray on 03/04/2023.
//

import UIKit
import MOLH
import Alamofire
import JGProgressHUD
import OneSignal
class LoginVC: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var remmbermeimg: UIImageView!
    var checkOldPassword : Bool?
    var AgreeIconClick : Bool! = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEBUG

        userName.text = "9651010730"
        password.text = "123456"
#endif
        
        
        if UserDefaults.standard.string(forKey: "rememberMe") == "1" {

         if let image = UIImage(named: "checked1") {
             remmbermeimg.image = image
          }

         AgreeIconClick = true

         // Set values
                  self.userName.text = UserDefaults.standard.string(forKey: "userMail") ?? ""
                  self.password.text = UserDefaults.standard.string(forKey: "userPassword") ?? ""

         }else{

         if let image = UIImage(systemName: "circle") {
             remmbermeimg.image = image
         }

         AgreeIconClick = false
        }
        
        
    }
    
 
    

    @IBAction func Login(_ sender: Any) {
        self.LoginRequest(email: self.userName.text ?? "", password: self.password.text ?? "")
    }
    
    @IBAction func SignUp(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "IdentfairVC") as! IdentfairVC
        vc.modalPresentationStyle = .fullScreen
  
        self.present(vc, animated: true)
        
    }
    @IBAction func forgetPassword(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPassword") as! ForgetPassword
        vc.checkOldPassword = true
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func remberMe(_ sender: Any) {
        
        if(AgreeIconClick == false) {

         if let image = UIImage(named: "checked1") {
             self.remmbermeimg.image = image
             
             UserDefaults.standard.set("1", forKey: "rememberMe")
             UserDefaults.standard.set(userName.text ?? "" , forKey: "userMail")
             UserDefaults.standard.set(password.text ?? "", forKey: "userPassword")

          
         }
            AgreeIconClick = true
            
         } else {
         if let image = UIImage(systemName: "circle") {
             self.remmbermeimg.image = image
             UserDefaults.standard.set("2", forKey: "rememberMe")

        }
            AgreeIconClick = false
        }

        
    }
    
    
    
    
    
    
    func LoginRequest(email:String,password:String) {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let userId = OneSignal.getDeviceState()?.userId
        
     
        let endpoint = URL(string:APIConfig.Login)
        let param: [String: String] = [
            "username": email,
            "password": password,
            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en",
            "login_type": "1"
            ,"device_player_id" : userId ?? ""
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
                                    
                                    if let message = jsonObj!["msg"] as? String {
                                        hud.dismiss()
                                        DispatchQueue.main.async {
                                            self.showErrorHud(msg: message, hud: hud)
                                            
                                            
                                        }
                                        
                                        
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
 
    
   
}
