//
//  ForgetPassword.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//


import UIKit
import MOLH
import Alamofire
import JGProgressHUD

class ForgetPassword: UIViewController {
    @IBOutlet weak var bellView: UIView!
    
    @IBOutlet weak var backView: UIStackView!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPasswrod: UITextField!
    @IBOutlet weak var confimNewPasword: UITextField!

    @IBOutlet weak var majorView: UIView!
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backView.layer.cornerRadius = 10
        self.backView.layer.backgroundColor = UIColor.black.cgColor
        self.backView.backgroundColor = UIColor.systemBackground
        self.backView.layer.shadowColor = UIColor.systemGray3.cgColor
        self.backView.layer.shadowOpacity = 0.6
        self.backView.layer.shadowRadius = 1
        self.backView.layer.shadowOffset = CGSize(width: 0, height: 10);
        self.backView.layer.shadowRadius = 5
            
        
        self.cerateBellView(bellview: bellView, count: "12")
        
        majorView.backgroundColor = .white
        
        majorView.roundCorners([.topLeft, .topRight], radius: 12)
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupSideMenu()

    }

    @IBAction func changePassword(snder:UIButton){
        self.forgetPassword(oldPassword: self.oldPassword.text ?? "", newPassword: self.newPasswrod.text ?? "", confirmPassword: self.confimNewPasword.text ?? "")
    }
    
    
    func forgetPassword(oldPassword:String,newPassword:String,confirmPassword:String) {
        let hud = JGProgressHUD(style: .light)
        
        hud.show(in: self.view)
        
        
        
     
        let endpoint = URL(string:APIConfig.Login)
        
        
        let param: [String: Any] = [
            "sessionId": Helper.shared.getUserSeassion()  ?? "",
            "currentPassword": oldPassword
            ,"confirmPassword" : confirmPassword,
            "newPassword": newPassword,
            "lang": MOLHLanguage.isRTLLanguage() ? "ar": "en"

        ]
        
        AF.request(endpoint!, method: .post, parameters: param).response { (response) in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        //    object status
                        
                            if let status = jsonObj!["status"] as? Bool {
                                
                                
                                
                                
                                if status == true {
                                     let message = jsonObj!["msg"] as? String
                                    
                                    let user_data = jsonObj!["user_data"] as? [String:Any]
                                    
                                    Helper.shared.saveToken(auth: user_data!["access_token"] as? String ?? "")
                                    Helper.shared.SaveSeassionId(seassionId: user_data!["sessionId"] as? String ?? "")
                                    Helper.shared.saveUserId(id:  user_data!["user_id"] as? Int ?? 1)

                                    
//                                    showing Done Flag
                                    self.showSuccessHud(msg: message ?? "", hud: hud)
                                    
                                    
                                    

                                    
                                        
                                        
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
