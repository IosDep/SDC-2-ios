//
//  AccountRecoveryUsername.swift
//  SDC
//
//  Created by Razan Barq on 17/07/2023.
//

import UIKit
import JGProgressHUD
import Alamofire
import MOLH

class AccountRecoveryUsername: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    var email : String?
    var mobileNum : String?
    static var sessionID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func nextPressed(_ sender: Any) {
        self.GetRecoveryData(username: usernameField.text ?? "")
    }
    
    func GetRecoveryData(username : String) {
            let hud = JGProgressHUD(style: .light)
            hud.show(in: self.view)
            
        let endpoint = URL(string:APIConfig.getRecoveryData)
            
            
            let param: [String: Any] = [
                "userName": username , "lang": MOLHLanguage.isRTLLanguage() ? "ar" : "en"
            ]
        
            
            AF.request(endpoint!, method: .post, parameters: param).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        
                        if jsonObj != nil {
                            
                            //    object status
                            let message = jsonObj!["message"] as? String
                            
                            let success = jsonObj!["success"] as? Bool
                            
                            if success == true {
                            if let status = jsonObj!["status"] as? Int {
                                
                                if status == 200 {
                                    
                                    
                                    if  let data = jsonObj!["data"] as? [String:Any] {
                                        
                                        AccountRecoveryUsername.sessionID =  data["sessionId"] as? String
                                        
                                        let email = data["email"] as? String
                                        self.email = email
                                        
                                        
                                        let mobile = data["mobile"] as? String
                                        self.mobileNum = mobile
                                        
                                        DispatchQueue.main.async {
                                            
                                            hud.dismiss()
                                            
                                            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            let vc = storyBoard.instantiateViewController(withIdentifier: "AccountRecovery") as! AccountRecovery
                                            vc.email = self.email
                                            vc.mobileNum = self.mobileNum
                                            vc.username = self.usernameField.text
                                            vc.modalPresentationStyle = .fullScreen
                                            self.present(vc, animated: true)
                                            
                                        }
                                    }
                                }
                                
                                //    status ==> false
                                else if status == 400 {
                                    
                                    DispatchQueue.main.async {
                                        self.showErrorHud(msg: message ?? "", hud: hud)
                                        
                                        
                                    }
                                    
                                }
                            }
                        }
                            else {
                                self.showErrorHud(msg: message ?? "", hud: hud)
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
