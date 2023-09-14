//
//  AccountRecovery.swift
//  SDC
//
//  Created by Razan Barq on 17/07/2023.
//

import UIKit
import JGProgressHUD
import Alamofire
import MOLH
import CountryPickerView


class AccountRecovery: UIViewController , SelectedNatDelegate , CountryPickerViewDelegate {
    

    @IBOutlet weak var recoveryBtn: UIButton!
    @IBOutlet weak var recoveryTextField: UITextField!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var countryPickerView: CountryPickerView!
    @IBOutlet weak var phoneTxt: UITextField!

    
    var email : String?
    var mobileNum : String?
    var recoveryInput : String?

    var username : String?
    var flag : String?
    var otp : String?
    var uniqueID : String?
    var phoneCode : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
        countryPickerView.font = UIFont.systemFont(ofSize: 14.0)

        emailView.isHidden = true
        mobileView.isHidden = true
        stackHeight.constant = 250
        
//        self.GetRecoveryData(username: self.username ?? "")

    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, willShow viewController: CountryPickerViewController) {
        
        
        // set the default jo
    }
    
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
       let pCode = countryPickerView.selectedCountry.phoneCode
        
        self.phoneCode = countryPickerView.selectedCountry.phoneCode.replacingOccurrences(of: "+", with: "00")

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
            
            emailView.isHidden = false
            mobileView.isHidden = true
            stackHeight.constant = 270
            recoveryTextField.placeholder = "Email".localized()
            recoveryTextField.keyboardType = .emailAddress
            
        }
        
        else if flag == "2" {
            
            self.flag = "2"
            recoveryBtn.setTitle(maskPhoneNumber(phoneNumber: selectdTxt), for: .normal)
            
            mobileView.isHidden = false
            emailView.isHidden = true
            stackHeight.constant = 270
            phoneTxt.keyboardType = .phonePad
            
//            recoveryTextField.placeholder = "Mobile Number".localized()
//            recoveryTextField.keyboardType = .numberPad
        }
        
    }
    

    
    @IBAction func nextPressed(_ sender: Any) {
        
            if flag == "1" {
                
                if recoveryInput == recoveryTextField.text {
                    self.requestOTPEmail(email: email ?? "")
                }
                else {
                    self.showWarningHud(msg: "Email doesn't match".localized())
                }
            }
            
            else if flag == "2" {
                
                if let phoneCode = phoneCode, let phoneText = phoneTxt.text {
                    let combinedPhoneNumber = phoneCode + self.removeLeadingZero(from: phoneText)
                    
                    if recoveryInput == combinedPhoneNumber {
                        self.requestOTPMobile(mobile: combinedPhoneNumber ?? "")
                    }
                    
                    else {
                        self.showWarningHud(msg: "Mobile doesn't match".localized())
                    }
                }
               
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
                "service_name" : "eportfolio" , "lang": MOLHLanguage.isRTLLanguage() ? "ar" : "en"
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
                                    
                                    vc.forgetCreate = true
                                    vc.uniqueID = uniqueId
                                    print("HHHH",self.uniqueID)
                                    print(self.uniqueID)
                                    print(self.uniqueID)
        
                                    vc.recoveryField = email
                                    
                                    vc.flag = self.flag
                                    vc.username = self.username
                                    vc.email = self.email
                                    vc.mobileNum = self.mobileNum
                                    self.modalPresentationStyle = .overCurrentContext
                                    self.present(vc, animated: true)
                                    
                                    hud.dismiss()
                                    
                                }
                            }
                            
                            else if code == 400 {
                                let resendId = jsonObj!["resendId"] as? String
                                
                                let msgg = "Invalid Otp".localized()
                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                
                                    }
                  
                     
                            else if code == 404 {
                                let resendId = jsonObj!["resendId"] as? String
                                
                                let msgg = "OTP expired".localized()
                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                
                                    }
                            
                            else if code == 504 {
                                let resendId = jsonObj!["resendId"] as? String
                                
                                let msgg = "Already active otp".localized()
                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                
                                    }
                            
                            else if code == 503 {
                                                let msgg = "Service unavailable".localized()
                                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                                    }
                                            
                            else if code == 413 {
                                                let msgg = "You have exceeded the allowed number of attempts, you can request a new verification code".localized()
                                                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
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
                                    
                                    vc.forgetCreate = true
                                    vc.uniqueID = uniqueId ?? "NO UNIaqyeID"
                                    vc.flag = self.flag
                                    vc.recoveryField = mobile
                                    vc.username = self.username
                                    vc.email = self.email
                                    vc.mobileNum = self.mobileNum
                                    
                                    self.present(vc, animated: true)
                                    
                                    hud.dismiss()
                                    
                                }
                            }
                            
                           
                            else if code == 400 {
                                let resendId = jsonObj!["resendId"] as? String
                                
                                let msgg = "Invalid Otp".localized()
                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                
                                    }
                  
                     
                            else if code == 404 {
                                let resendId = jsonObj!["resendId"] as? String
                                
                                let msgg = "OTP expired".localized()
                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                
                                    }
                            
                            else if code == 504 {
                                let resendId = jsonObj!["resendId"] as? String
                                
                                let msgg = "Already active otp".localized()
                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                
                                    }
                            
                            else if code == 503 {
                                                let msgg = "Service unavailable".localized()
                                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                                    }
                                            
                            else if code == 413 {
                                                let msgg = "You have exceeded the allowed number of attempts, you can request a new verification code".localized()
                                                                self.showErrorHud(msg: msgg ?? "" , hud: hud)
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
    

    func removeLeadingZero(from string: String) -> String {
        if string.hasPrefix("0") {
            return String(string.dropFirst())
        }
        return string
    }
     
        
    }
    
    
    



