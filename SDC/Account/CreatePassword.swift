//
//  CreatePassword.swift
//  SDC
//
//  Created by Razan Barq on 18/07/2023.
//

import UIKit
import JGProgressHUD
import Alamofire

class CreatePassword: UIViewController {
    
    @IBOutlet weak var backView: UIStackView!
    @IBOutlet weak var majorView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backView.layer.cornerRadius = 23
        self.backView.layer.backgroundColor = UIColor.black.cgColor
        self.backView.backgroundColor = UIColor.systemBackground
        self.backView.layer.shadowColor = UIColor.systemGray3.cgColor
        backView.layer.shadowOpacity = 2
        backView.layer.shadowRadius = 23
        backView.layer.shadowOffset = .zero
        backView.layer.shadowPath = UIBezierPath(rect: backView.bounds).cgPath
        backView.layer.shouldRasterize = true
//        self.cerateBellView(bellview: bellView, count: "12")
        self.majorView.backgroundColor = .white

    }
    
    
    override func viewDidLayoutSubviews() {
        self.majorView.roundCorners([.topLeft, .topRight], radius: 12)
   
    }
    


    @IBAction func sendPressed(_ sender: Any) {
        
        if newPasswordField.text != "" && confirmPasswordField.text != "" {
            
            if newPasswordField.text?.count ?? 0 < 8 {
                self.showErrorHud(msg: "Please Enter 8 digits")
            }
            
            else {
                
                if newPasswordField.text == confirmPasswordField.text {
                    CreatePassword()
                }
            }
            
        }
        
        else {
            self.showErrorHud(msg: "Please Enter required fields")
        
        }
        
    }
    
    func CreatePassword() {
            let hud = JGProgressHUD(style: .light)
            
            hud.show(in: self.view)
            
            
        let endpoint = URL(string:APIConfig.CreatePassword)
            
            
            let param: [String: Any] = [
                "sessionId":  AccountRecoveryUsername.sessionID ?? "",
                "new_pass": newPasswordField.text ?? "",
                "confirm_pass" : confirmPasswordField.text ?? ""

            ]
            
            AF.request(endpoint!, method: .post, parameters: param).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        
                        if jsonObj != nil {
                            
                                                        
                                if let status = jsonObj!["status"] as? Int {
                                
                                if status == 200 {
                                        
                                    if UserDefaults.standard.bool(forKey: "biometricAuthenticationEnabled") == true {
                                        
                                        if let user = ApplicationData.shared.getAccountsList()?.first {
                                            
                                            ApplicationData.shared.updateAccount(with: Account(userName: user.userName, password: self.newPasswordField.text ?? ""))
                                            
                                        }
                                    }
                                        
                        if  let data = jsonObj!["data"] as? String {
                            
                                            
                DispatchQueue.main.async {
                self.showSuccessHud(msg: data, hud: hud)
                                
                self.dismiss(animated: true , completion: {
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                                
                let vc = storyBoard.instantiateViewController(withIdentifier: "WelcomePageVC") as! WelcomePageVC
                                            vc.modalPresentationStyle = .overCurrentContext
                                                                
                                            self.present(vc, animated: true , completion: nil)
                                            
                                        })
                                                
                                            }
                                        }
                                    }
                                    //    status ==> false
                                    else {
                                        
                                if let message = jsonObj!["message"] as? String {
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
