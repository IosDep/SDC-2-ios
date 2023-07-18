//
//  AccountRecovery.swift
//  SDC
//
//  Created by Razan Barq on 17/07/2023.
//

import UIKit
import JGProgressHUD
import Alamofire


class AccountRecovery: UIViewController , SelectedNatDelegate {
    
   

    @IBOutlet weak var recoveryBtn: UIButton!
    @IBOutlet weak var recoveryTextField: UITextField!
    
    var email : String?
    var mobileNum : String?
    var recoveryInput : String?

    var username : String?
    var flag : String?
    var otp : String?
    var uniqueID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.GetRecoveryData(username: self.username ?? "")

    }
    

    @IBAction func recoveryPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AccountRecoveryPopUp") as! AccountRecoveryPopUp
        vc.email = self.email
        vc.selectedNatDelegate = self
        vc.mobileNum = self.mobileNum
        self.present(vc, animated: true)
        
    }
    
    func getSelectdPicker(selectdTxt: String, flag: String) {
        
        recoveryInput = selectdTxt
        
        if flag == "1" {
            
            self.flag = "1"
            recoveryBtn.setTitle(maskEmail(email: selectdTxt), for: .normal)
            recoveryTextField.placeholder = "Email"
            recoveryTextField.keyboardType = .emailAddress
        }
        
        else if flag == "2" {
            
            self.flag = "2"
            recoveryBtn.setTitle(maskPhoneNumber(phoneNumber: selectdTxt), for: .normal)
            recoveryTextField.placeholder = "Mobile Number"
            recoveryTextField.keyboardType = .numberPad
        }
        
    }
    
    
    
    @IBAction func nextPressed(_ sender: Any) {
        
        if recoveryInput == recoveryTextField.text {
            
            if flag == "1" {
                self.requestOTPEmail(email: email ?? "")
            }
            
            else if flag == "2" {
                self.requestOTPMobile(mobile: mobileNum ?? "")
            }
            
        }
        
        else {
            self.showErrorHud(msg: "Doesn't match".localized())
        }
        
    }
    
   
    func requestOTPEmail(email : String) {
        
            let hud = JGProgressHUD(style: .light)
            hud.show(in: self.view)
        
        let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-request"
            
        let endpoint = URL(string: urlString)
            
            let param: [String: Any] = [
                "email": email ,
                "client_req_id" : username ,
                "service_name" : "eportfolio"
            ]
        
        let username = "sdc"
        let password = "sdc@2022"
            
        let credentialData = "\(username):\(password)".data(using: .utf8)!
            let base64Credentials = credentialData.base64EncodedString()
            let headers = HTTPHeaders(["Authorization": "Basic \(base64Credentials)"])
            
            AF.request(endpoint!, method: .post, parameters: param , headers: headers).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        
                        if jsonObj != nil {
                             
                                    
                            let message = jsonObj!["message"] as? String
                            
                            
                            let code = jsonObj!["code"] as? Int
                            
                            if code == 201 {
                                let uniqueId = jsonObj!["uniqueId"] as? String
                                
                                let type = jsonObj!["type"] as? String
                                
                                DispatchQueue.main.async {
                                    
                                    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpOTP") as! PopUpOTP
                                    vc.otp = self.otp
                                    vc.uniqueID = uniqueId
                                    
                                    print("HHHH",self.uniqueID)
                                    print(self.uniqueID)
                                    print(self.uniqueID)
                                    
                                    vc.recoveryField = email
                                    vc.flag = self.flag
                                    self.present(vc, animated: true)
                                    
                                    hud.dismiss()
                                    
                                }
                            }
                            
                    else {
                        hud.dismiss()
                    self.showErrorHud(msg: message ?? "")
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
    
    func requestOTPMobile(mobile : String) {
        
            let hud = JGProgressHUD(style: .light)
            hud.show(in: self.view)
            
        let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-request"
        
        let endpoint = URL(string: urlString)
            
            let param: [String: Any] = [
                "mobile": mobile ,
                "client_req_id" : username ,
                "service_name" : "eportfolio"
            ]
        
        let username = "sdc"
        let password = "sdc@2022"
            
        let credentialData = "\(username):\(password)".data(using: .utf8)!
            let base64Credentials = credentialData.base64EncodedString()
            let headers = HTTPHeaders(["Authorization": "Basic \(base64Credentials)"])
            
            
            AF.request(endpoint!, method: .post, parameters: param , headers: headers).response { (response) in
                if response.error == nil {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        
                        if jsonObj != nil {
                            
                            let message = jsonObj!["message"] as? String
                            
                            
                            let code = jsonObj!["code"] as? Int
                            
                            if code == 201 {
                                
                                let uniqueId = jsonObj!["uniqueId"] as? String
                                
                                let type = jsonObj!["type"] as? String
                                
                                
                                DispatchQueue.main.async {
                                    
                                    let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let vc = storyBoard.instantiateViewController(withIdentifier: "PopUpOTP") as! PopUpOTP
                                    vc.otp = self.otp
                                   

                                    vc.uniqueID = uniqueId ?? "NO UNIaqyeID"
                                    vc.flag = self.flag
                                    vc.recoveryField = mobile
                                    self.present(vc, animated: true)
                                    
                                    hud.dismiss()
                                    
                                }
                            }
                            
                           
                            else {
                                hud.dismiss()
                                self.showErrorHud(msg: message ?? "")
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
    
    func maskEmail(email: String) -> String {
        let components = email.components(separatedBy: "@")
        let username = components[0]
        let domain = components[1]
        
        let maskedUsername = String(username.prefix(1)) + String(repeating: "*", count: username.count ) + String(username.suffix(1))
        
        return maskedUsername + "@" + domain
    }
    
    func maskPhoneNumber(phoneNumber: String) -> String {
        let countryCode = String(phoneNumber.prefix(5))
        let maskedNumber = String(repeating: "*", count: phoneNumber.count - 7)
        let lastDigits = String(phoneNumber.suffix(2))
        
        return countryCode + maskedNumber + lastDigits
    }
    

     
     
        
    }
    
    
    



