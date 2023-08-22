//
//  PopUpOTP.swift
//  SDC
//
//  Created by Blue Ray on 14/04/2023.
//

import UIKit
import JGProgressHUD
import Alamofire

class PopUpOTP: UIViewController {

    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var otpTxt: UITextField!
    
    
    @IBOutlet weak var verificationMessage: DesignableLabel!
    @IBOutlet weak var recoveryInput: UILabel!
    
    @IBOutlet weak var resendCodeLabel: DesignableLabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var otp : String?
    var uniqueID : String?
    var recoveryField : String?
    var flag : String?
    var username : String?
    var email : String?
    var mobileNum : String?
    
    var forgetCreate = false
    var checkEmailPhone:String?
    

    @IBOutlet weak var resendBtn: UIButton!
    
    var remainingTime = 180
    var timer: Timer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        resendBtn.isEnabled = false
        resendCodeLabel.textColor = .lightGray

        
        if forgetCreate == true {
            
            if flag == "1" {
                verificationMessage.text = "A message containing OTP code were sent to the Email".localized()
            }

            else if flag == "2" {
                verificationMessage.text = "A message containing OTP code were sent to the Mobile".localized()
            }
            
            recoveryInput.text = recoveryField

            
        }
        
        else {
            if checkEmailPhone == "1" {
                
                verificationMessage.text = "A message containing OTP code were sent to the Email".localized()
                recoveryInput.text = IdentfairVC.phoneNum ?? ""
                
            }
            
            else if checkEmailPhone == "2" {
                
                verificationMessage.text = "A message containing OTP code were sent to the Mobile".localized()
                
                recoveryInput.text = IdentfairVC.email ?? ""
            }
            
        }
        
        
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                self?.updateTimer()
            })
        
    }
    
    
    @IBAction func resendCodePressed(_ sender: Any) {
        
        
        if flag == "1" {
               self.requestOTP(recoveryInput: self.email ?? "", parameter: "email")
           } else if flag == "2" {
               self.requestOTP(recoveryInput: self.mobileNum ?? "", parameter: "mobile")
           }
           
           remainingTime = 180
           updateTimer()
        
        
    }
    


    @IBAction func Next(_ sender: Any) {
        
        if forgetCreate == true {
            if otpTxt.text != "" {
                self.validateOTP(OTP: otpTxt.text ?? "")
            }
            
        }
        
        else {
            self.vvalidateOTP(OTP: otpTxt.text ?? "")
        }
        
    }
    
    
    func validateOTP(OTP : String) {
            let hud = JGProgressHUD(style: .light)
            hud.show(in: self.view)
        
        let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-validate"
            
        let endpoint = URL(string: urlString)
            
            
            let param: [String: Any] = [
                "uniqueId": uniqueID ?? "",
                "otp": OTP

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
                            
                            if  let code = jsonObj!["code"] as? Int {
                                
                                if code == 200 {
                                    
                                    let type = jsonObj!["type"] as? String
                                    
                                   
                    DispatchQueue.main.async {
                    self.showSuccessHud(msg: message ?? "OTP Verified")
                        
                       
                        hud.dismiss()
                        
                    self.dismiss(animated: true , completion: {
                                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                    
                                let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePassword") as! CreatePassword
                                vc.modalPresentationStyle = .overCurrentContext
                                                    
                                self.present(vc, animated: true , completion: nil)
                                
                            })
                            
                       
                                    }
                                    
                                }
                                
                                // ,completion: {self.dismiss(animated: true)}
                                
//                                => invalid otp
                                
                                else if code == 400 {
                                    let resendId = jsonObj!["resendId"] as? String
                                    
                                    let msgg = "Invalid Otp".localized()
                                    self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                    
                                        }
                      
                         
                                else if code == 404 {
                                    let resendId = jsonObj!["resendId"] as? String
                                    
                                    let msgg = "OTP expierd".localized()
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
    
    func vvalidateOTP(OTP : String) {
                    let hud = JGProgressHUD(style: .light)
                    hud.show(in: self.view)
                
                let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-validate"
                    
                let endpoint = URL(string: urlString)
                    
                    
                    let param: [String: Any] = [
                        "uniqueId": uniqueID ?? "",
                        "otp": OTP

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
                                    
                                    if  let code = jsonObj!["code"] as? Int {
                                        
                                        if code == 200 {
                                            
                                            let type = jsonObj!["type"] as? String
                                            
                                           
                            DispatchQueue.main.async {
                            self.showSuccessHud(msg: message ?? "OTP Verified")
                                
                                if self.forgetCreate == true {
                                    
                                    hud.dismiss()
                                    
                                self.dismiss(animated: true , completion: {
                                            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                                                
                                            let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePassword") as! CreatePassword
                                            vc.modalPresentationStyle = .overCurrentContext
                                                                
                                            self.present(vc, animated: true , completion: nil)
                                            
                                        })
                                    
                                    
                                    
                                }else {
                                    
                                    if self.checkEmailPhone == "1" {
                                        
                                        hud.dismiss()

                                        
                                        self.dismiss(animated: true , completion: {
                                            
                                            
                                            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            
                                            let vc = storyBoard.instantiateViewController(withIdentifier: "EmailVc") as! EmailVc
                                            vc.modalPresentationStyle = .fullScreen
                                            //
                                            self.present(vc, animated: true)
                                            
                                        })
                                        
                                        
                                    }
                                    else if self.checkEmailPhone == "2"{
                                        
                                        hud.dismiss()
                                        
                                        //            email gooing to Summary
                                        self.dismiss(animated: true , completion: {
                                            
                                            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            
                                            
                                            let vc = storyBoard.instantiateViewController(withIdentifier: "AgrementVc") as! AgrementVc
                                            vc.modalPresentationStyle = .fullScreen
                                            
                                            self.present(vc, animated: true)
                                        })
                                        
                                    }
                                    
                                    
                                }
                                
                                
                                
                  
                                    
                               
                                            }
                                            
                                        }
                                        
                                        // ,completion: {self.dismiss(animated: true)}
                                        
        //                                => invalid otp
                                        
                                        else if code == 400 {
                                            let resendId = jsonObj!["resendId"] as? String
                                            
                                            let msgg = "Invalid Otp".localized()
                                            self.showErrorHud(msg: msgg ?? "" , hud: hud)
                                            
                                                }
                              
                                 
                                        else if code == 404 {
                                            let resendId = jsonObj!["resendId"] as? String
                                            
                                            let msgg = "OTP expierd".localized()
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
    
    
    func requestOTP(recoveryInput : String , parameter : String) {
        
            let hud = JGProgressHUD(style: .light)
            hud.show(in: self.view)
        
        let urlString = "http://194.165.152.9/otp-service/api/sdc/otp-request"
            
        let endpoint = URL(string: urlString)
            
            let param: [String: Any] = [
                parameter: recoveryInput ,
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
                                
                                self.uniqueID = uniqueId
                                
                                let type = jsonObj!["type"] as? String
                                
                                DispatchQueue.main.async {
                                    
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
                                
                                let msgg = "OTP expierd".localized()
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
    
    
    
    
    func updateTimer() {
        if remainingTime > 0 {
            remainingTime -= 1
            
            let minutes = remainingTime / 60
            let seconds = remainingTime % 60
            
            let formattedTime = String(format: "%02d:%02d", minutes, seconds)
            timerLabel.text = formattedTime
        } else {
            resendBtn.isEnabled = true
            resendCodeLabel.textColor = .black
            timer?.invalidate()
            timer = nil
            
        }
    }

    
}
